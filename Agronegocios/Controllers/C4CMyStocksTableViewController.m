//
//  C4CMyStocksTableViewController.m
//  Agronegocios
//
//  Created by David Almeciga on 11/2/14.
//  Copyright (c) 2014 COOL4CODE. All rights reserved.
//

#import "C4CMyStocksTableViewController.h"

@interface C4CMyStocksTableViewController () <NSFetchedResultsControllerDelegate>
{
    MBProgressHUD *hud;
}

@end

@implementation C4CMyStocksTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIRefreshControl *refreshControl = [UIRefreshControl new];
    [refreshControl addTarget:self action:@selector(loadData) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
    // [self.refreshControl beginRefreshing];
    
    UIColor *bgColor = [UIColor colorWithRed:1 green:0.91 blue:0.74 alpha:1];
    
    self.tableView.backgroundView.backgroundColor = bgColor;
    self.tableView.backgroundColor = bgColor;
    self.refreshControl.backgroundColor = bgColor;
    self.view.backgroundColor = bgColor;
    
    self.fetchedResultsController = [self newFetchedResultsController];
    
    hud = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:hud];
    hud.labelText = @"¡Preparando mi inventario!";
    hud.color = [UIColor colorWithRed:0 green:0.6 blue:0.8 alpha:0.9];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [hud show:YES];
    [self loadData];
}

- (NSFetchedResultsController *)newFetchedResultsController {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"MyStock"];
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"stockId" ascending:YES];
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
    [objectManager getObjectsAtPath:MYSTOCKS_PATH
                         parameters:nil
                            success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                [self.tableView reloadData];
                                [hud hide:YES];
                            }
                            failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                RKLogError(@"Error: %@", error);
                                C4CShowAlertWithError(error);
                                [hud hide:YES];
                            }];
    
    [self performSelector:@selector(endRefreshControl) withObject:nil afterDelay:1.5];
}

- (void) endRefreshControl{
    [self.refreshControl endRefreshing];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.section == 1 ? 44 : 80;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = self.tableView.backgroundColor = [UIColor colorWithRed:1 green:0.91 blue:0.74 alpha:1];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    /*if (tableView == self.tableView) {
        return [[self.fetchedResultsController sections] count] + 1;
    } else if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [[self.searchFetchedResultsController sections] count] + 1;
    }*/
    
    return 3;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        if (tableView == self.tableView) {
            return [[[self.fetchedResultsController sections] objectAtIndex:0] numberOfObjects];
        } else if (tableView == self.searchDisplayController.searchResultsTableView) {
            return [[[self.searchFetchedResultsController sections] objectAtIndex:0] numberOfObjects];
        }
    } else {
        return 1;
    }
    
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        
        NSString *reuseIdentifier = @"mystockCell";
        C4CStockTableViewCell *cell = (C4CStockTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
        
        if (cell == nil) {
            cell = [[C4CStockTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        }
        
        MyStock *stock = nil;
        if (tableView == self.tableView) {
            stock = [_fetchedResultsController objectAtIndexPath:indexPath];
        } else if (tableView == self.searchDisplayController.searchResultsTableView) {
            stock = [_searchFetchedResultsController objectAtIndexPath:indexPath];
        }
        
        [cell.productName setText:stock.productName];
        [cell.expiresAt setText:[NSString stringWithFormat:@"Vence: %@", [NSDate stringFromDate:stock.expiresAt withFormat:@"dd MMM YYYY"]]];
        [cell.userName setText:stock.userName];
        [cell.price setText:[NSNumberFormatter localizedStringFromNumber:stock.pricePerUnit numberStyle:NSNumberFormatterCurrencyStyle]];
        [cell.qty  setText:[NSString stringWithFormat:@"Cant: %@",[NSNumberFormatter localizedStringFromNumber:stock.qty numberStyle:NSNumberFormatterDecimalStyle]]];
        [cell.unit setText:stock.unitName];
        
        
        UIView *selectedBackgroupdView = [[UIView alloc] init];
        selectedBackgroupdView.backgroundColor = [UIColor colorWithRed:0.09 green:0.6 blue:0.79 alpha:0.3];
        [cell setSelectedBackgroundView:selectedBackgroupdView];
        
        return cell;
        
    } else if (indexPath.section == 1) {
        UITableViewCell *newstockCell = [self.tableView dequeueReusableCellWithIdentifier:@"newstockCell"];
        return newstockCell;
        
    } else {
        UITableViewCell *doncampoCell = [self.tableView dequeueReusableCellWithIdentifier:@"doncampoCell"];
        return doncampoCell;
        
    }
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

static void C4CShowAlertWithError(NSError *error)
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                    message:[error localizedDescription]
                                                   delegate:nil
                                          cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showStockDetail"]) {
        NSIndexPath *indexPath = nil;
        MyStock *stock = nil;
        
        if (self.searchDisplayController.active) {
            indexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
            stock = [_searchFetchedResultsController objectAtIndexPath:indexPath];
        } else {
            indexPath = [self.tableView indexPathForSelectedRow];
            stock = [_fetchedResultsController objectAtIndexPath:indexPath];
        }
        
        C4CMyStockDetailTableViewController *detailViewController = segue.destinationViewController;
        detailViewController.stock = stock;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
