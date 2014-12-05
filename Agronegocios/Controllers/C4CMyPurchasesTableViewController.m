//
//  C4CMyPurchasesTableViewController.m
//  Agronegocios
//
//  Created by David Almeciga on 11/2/14.
//  Copyright (c) 2014 COOL4CODE. All rights reserved.
//

#import "C4CMyPurchasesTableViewController.h"

@interface C4CMyPurchasesTableViewController () <NSFetchedResultsControllerDelegate>
{
    SAMHUDView *hud;
}

@end

@implementation C4CMyPurchasesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIRefreshControl *refreshControl = [UIRefreshControl new];
    [refreshControl addTarget:self action:@selector(loadData) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
    //[self.refreshControl beginRefreshing];
    
    UIColor *bgColor = [UIColor colorWithRed:1 green:0.91 blue:0.74 alpha:1];
    
    self.tableView.backgroundView.backgroundColor = bgColor;
    self.tableView.backgroundColor = bgColor;
    self.refreshControl.backgroundColor = bgColor;
    self.view.backgroundColor = bgColor;
    
    self.title = @"Mis compras";
    self.fetchedResultsController = [self newFetchedResultsController];
    
    hud = [[SAMHUDView alloc] initWithTitle:@"¡Preparando mis compras!" loading:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [hud show];
    [self loadData];
}

- (NSFetchedResultsController *)newFetchedResultsController {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"MyPurchases"];
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"orderId" ascending:YES];
    fetchRequest.sortDescriptors = @[descriptor];
    NSError *error = nil;
    
    NSFetchedResultsController *fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                                               managedObjectContext:[RKManagedObjectStore defaultStore].mainQueueManagedObjectContext
                                                                                                 sectionNameKeyPath:nil
                                                                                                          cacheName:nil];
    
    [fetchedResultsController setDelegate:self];
    if (![fetchedResultsController performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        C4CShowAlertWithError(error);
        abort();
    }
    
    return fetchedResultsController;
}

- (NSString *)accessToken
{
    NSError *error = nil;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Token"];
    [fetchRequest setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"issuedAt" ascending:NO]]];
    NSArray *result = [[RKObjectManager sharedManager].managedObjectStore.mainQueueManagedObjectContext executeFetchRequest:fetchRequest error:&error];
    Token *lastToken = [result lastObject];
    return lastToken.accessToken;
}

- (void)loadData {
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
    [objectManager.HTTPClient setDefaultHeader:@"Authorization" value:[NSString stringWithFormat:@"Bearer %@", [self accessToken]]];
    [objectManager getObjectsAtPath:MYPURCHASES_PATH
                         parameters:nil
                            success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                [self.tableView reloadData];
                                [hud dismiss];
                            }
                            failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                RKLogError(@"Error: %@", error);
                                C4CShowAlertWithError(error);
                                [hud dismiss];
                            }];
    
    [self performSelector:@selector(endRefreshControl) withObject:nil afterDelay:1.5];
}

- (void) endRefreshControl{
    [self.refreshControl endRefreshing];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = self.tableView.backgroundColor = [UIColor colorWithRed:1 green:0.91 blue:0.74 alpha:1];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.tableView) {
        return [[self.fetchedResultsController sections] count];
    } else if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [[self.searchFetchedResultsController sections] count];
    }
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tableView) {
        return [[[self.fetchedResultsController sections] objectAtIndex:section] numberOfObjects];
    } else if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [[[self.searchFetchedResultsController sections] objectAtIndex:section] numberOfObjects];
    }
    
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseIdentifier = @"mypurchasesCell";
    C4COrderTableViewCell *cell = (C4COrderTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil) {
        cell = [[C4COrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    
    MyPurchases *order = nil;
    if (tableView == self.tableView) {
        order = [_fetchedResultsController objectAtIndexPath:indexPath];
    } else if (tableView == self.searchDisplayController.searchResultsTableView) {
        order = [_searchFetchedResultsController objectAtIndexPath:indexPath];
    }
    
    [cell.productName setText:order.productName];
    [cell.expiresAt setText:[NSString stringWithFormat:@"Vence: %@", [NSDate stringFromDate:order.expiresAt withFormat:@"dd MMM YYYY"]]];
    [cell.userName setText:order.stockUserName];
    [cell.pricePerUnit setText:[NSNumberFormatter localizedStringFromNumber:order.pricePerUnit numberStyle:NSNumberFormatterCurrencyStyle]];
    [cell.qty  setText:[NSString stringWithFormat:@"Cant: %@",[NSNumberFormatter localizedStringFromNumber:order.orderQty numberStyle:NSNumberFormatterDecimalStyle]]];
    [cell.unitName setText:order.unitName];
    
    
    UIView *selectedBackgroupdView = [[UIView alloc] init];
    selectedBackgroupdView.backgroundColor = [UIColor colorWithRed:1 green:0.27 blue:0.27 alpha:0.3];
    [cell setSelectedBackgroundView:selectedBackgroupdView];
    
    return cell;
}


#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    if (controller == self.fetchedResultsController) {
        [self.tableView beginUpdates];
    } else if (controller == self.searchFetchedResultsController) {
        [self.searchDisplayController.searchResultsTableView beginUpdates];
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    if (controller == self.fetchedResultsController) {
        [self.tableView endUpdates];
    } else if (controller == self.searchFetchedResultsController) {
        [self.searchDisplayController.searchResultsTableView endUpdates];
    }
}

#pragma mark - Fetched results controller

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.tableView;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

#pragma mark - UISearchDisplayDelegate

- (void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller
{
    self.searchFetchedResultsController = [self newFetchedResultsController];
}

- (void)searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller
{
    self.searchFetchedResultsController = nil;
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    NSPredicate *predicate = [RKSearchPredicate searchPredicateWithText:searchString type:NSAndPredicateType];
    self.searchFetchedResultsController.fetchRequest.predicate = predicate;
    NSError *error = nil;
    [self.searchFetchedResultsController performFetch:&error];
    
    return YES;
}

# pragma mark

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showOrderDetail"]) {
        NSIndexPath *indexPath = nil;
        MyPurchases *order = nil;
        
        if (self.searchDisplayController.active) {
            indexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
            order = [_searchFetchedResultsController objectAtIndexPath:indexPath];
        } else {
            indexPath = [self.tableView indexPathForSelectedRow];
            order = [_fetchedResultsController objectAtIndexPath:indexPath];
        }
        
        C4CMyPurchasesDetailTableViewController *detailViewController = segue.destinationViewController;
        detailViewController.order = order;
    }
}


static void C4CShowAlertWithError(NSError *error)
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                    message:[error localizedDescription]
                                                   delegate:nil
                                          cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
