//
//  C4CPriceTableViewController.m
//  Agronegocios
//
//  Created by David Almeciga on 10/19/14.
//  Copyright (c) 2014 COOL4CODE. All rights reserved.
//

#import "C4CPriceTableViewController.h"

@interface C4CPriceTableViewController ()  <NSFetchedResultsControllerDelegate>
{
    SAMHUDView *hud;
}

@end

@implementation C4CPriceTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIRefreshControl *refreshControl = [UIRefreshControl new];
    [refreshControl addTarget:self action:@selector(loadData) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
    // [self.refreshControl beginRefreshing];
    
    self.fetchedResultsController = [self newFetchedResultsController];
    [self loadData];
    
    UIColor *bgColor = [UIColor colorWithRed:1 green:0.91 blue:0.74 alpha:1];
    
    self.tableView.backgroundView.backgroundColor = bgColor;
    self.tableView.backgroundColor = bgColor;
    self.refreshControl.backgroundColor = bgColor;
    self.view.backgroundColor = bgColor;
    
    self.title = @"Precios";
    
    hud = [[SAMHUDView alloc] initWithTitle:@"Descargando listas!" loading:YES];
    [hud show];

}

- (NSFetchedResultsController *)newFetchedResultsController {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Price"];
    NSSortDescriptor *byDateDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"createdAt" ascending:NO];
    NSSortDescriptor *byProductNameDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"productName" ascending:YES];
    fetchRequest.sortDescriptors = @[byDateDescriptor, byProductNameDescriptor];
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

- (void)loadData {
    [[RKObjectManager sharedManager] getObjectsAtPath:PRICES_PATH
                                           parameters:nil
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  [hud dismiss];
                                                  /*[[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"LastUpdatedAt"];
                                                  [[NSUserDefaults standardUserDefaults] synchronize];*/
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
    return 75;
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

/*
 - (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSDate *lastUpdatedAt = [[NSUserDefaults standardUserDefaults] objectForKey:@"LastUpdatedAt"];
    NSString *dateString = [NSDateFormatter localizedStringFromDate:lastUpdatedAt dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterMediumStyle];
    if (nil == dateString) {
        dateString = @"ninguna";
    }
    return [NSString stringWithFormat:@"Última actualización: %@", dateString];
}
 */

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseIdentifier = @"priceCell";
    C4CPriceTableViewCell *cell = (C4CPriceTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil) {
        cell = [[C4CPriceTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    
    Price *price = nil;
    if (tableView == self.tableView) {
        price = [_fetchedResultsController objectAtIndexPath:indexPath];
    } else if (tableView == self.searchDisplayController.searchResultsTableView) {
        price = [_searchFetchedResultsController objectAtIndexPath:indexPath];
    }
    
    [cell.productName setText:price.productName];
    [cell.createDate setText:[NSDate stringForDisplayFromDate:price.createdAt]];
    [cell.location setText:price.location];
    [cell.price setText:[NSNumberFormatter localizedStringFromNumber:price.priceAvgPerUnit numberStyle:NSNumberFormatterCurrencyStyle]];
    [cell.unit setText:price.unitName];

    
    UIView *selectedBackgroupdView = [[UIView alloc] init];
    selectedBackgroupdView.backgroundColor = [UIColor colorWithRed:0.4 green:0.6 blue:0 alpha:0.6];
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
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
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

#pragma mark - Login Button Action

- (IBAction)loginAction:(id)sender {
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    C4CRootFormViewController *loginView = [storyBoard instantiateViewControllerWithIdentifier:@"loginView"];
    C4CWhoamiTableViewController *whoamiView = [storyBoard instantiateViewControllerWithIdentifier:@"whoamiView"];
    
    NSError *error = nil;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Token"];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"issuedAt" ascending:NO];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    NSArray *results = [[RKObjectManager sharedManager].managedObjectStore.mainQueueManagedObjectContext executeFetchRequest:fetchRequest error:&error];

    Token *lastToken = [results lastObject];
    if (lastToken == nil && [NSDate date] >= lastToken.expiresAt) {
       [self.navigationController pushViewController:loginView animated:YES];
    } else {
       [self.navigationController pushViewController:whoamiView animated:YES];        
    }
    
}

#pragma mark

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showPriceDetail"]) {
        NSIndexPath *indexPath = nil;
        Price *price = nil;
        
        if (self.searchDisplayController.active) {
            indexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
            price = [_searchFetchedResultsController objectAtIndexPath:indexPath];
        } else {
            indexPath = [self.tableView indexPathForSelectedRow];
            price = [_fetchedResultsController objectAtIndexPath:indexPath];
        }
        
        C4CPriceDetailTableViewController *detailViewController = segue.destinationViewController;
        detailViewController.price = price;
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
