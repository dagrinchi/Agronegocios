//
//  C4CMyPurchasesDetailTableViewController.m
//  Agronegocios
//
//  Created by David Almeciga on 11/9/14.
//  Copyright (c) 2014 COOL4CODE. All rights reserved.
//

#import "C4CMyPurchasesDetailTableViewController.h"

@interface C4CMyPurchasesDetailTableViewController ()
{
    NSArray * orderDetails;
}

@end

@implementation C4CMyPurchasesDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIColor *bgColor = [UIColor colorWithRed:1 green:0.91 blue:0.74 alpha:1];
    
    self.tableView.backgroundView.backgroundColor = bgColor;
    self.tableView.backgroundColor = bgColor;
    self.refreshControl.backgroundColor = bgColor;
    self.view.backgroundColor = bgColor;
    
    orderDetails = @[@{@"labelText":@"Producto", @"fieldText":_order.productName},
                     @{@"labelText":@"Unidad", @"fieldText":_order.unitName},
                     @{@"labelText":@"Cantidad", @"fieldText":[NSNumberFormatter localizedStringFromNumber:_order.orderQty numberStyle:NSNumberFormatterDecimalStyle]},
                     @{@"labelText":@"Precio", @"fieldText":[NSNumberFormatter localizedStringFromNumber:_order.pricePerUnit numberStyle:NSNumberFormatterCurrencyStyle]},
                     @{@"labelText":@"Vence", @"fieldText":[NSDate stringFromDate:_order.expiresAt withFormat:@"dd MMM YYYY"]},
                     @{@"labelText":@"Ubicación", @"fieldText":[NSString stringWithFormat:@"%@, %@, %@ - %@", _order.orderAddress, _order.orderTown, _order.orderState, _order.orderCountry]},
                     @{@"labelText":@"Productor", @"fieldText":_order.stockUserName},
                     @{@"labelText":@"Email", @"fieldText":_order.stockUserEmail}];
    
    self.title = _order.productName;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Atras" style:UIBarButtonItemStylePlain target:nil action:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 0 ? [orderDetails count] : 1;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = self.tableView.backgroundColor = [UIColor colorWithRed:1 green:0.91 blue:0.74 alpha:1];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (indexPath.section == 0) {
        cell = (UITableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:@"orderCell"];
        
        NSDictionary *orderDetail = nil;
        orderDetail = [orderDetails objectAtIndex:indexPath.row];
        
        [cell.textLabel setText:orderDetail[@"labelText"]];
        [cell.detailTextLabel setText:orderDetail[@"fieldText"]];
        
        UIView *selectedBackgroupdView = [[UIView alloc] init];
        selectedBackgroupdView.backgroundColor = [UIColor colorWithRed:1 green:0.27 blue:0.27 alpha:0.3];
        [cell setSelectedBackgroundView:selectedBackgroupdView];
        
    } else if (indexPath.section == 1) {
        cell = (UITableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:@"buttonCell"];
    }
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"orderCell"];
    }
    
    return cell;
}

#pragma mark

- (IBAction)deleteAction:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"¿Desea countinar?"
                                                    message:[NSString stringWithFormat:@"Va a eliminar el pedido #%@, esta acción no se puede reversar.", _order.orderId]
                                                   delegate:self
                                          cancelButtonTitle:@"Cancelar"
                                          otherButtonTitles:@"Continuar", nil];
    [alert show];
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

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSManagedObjectContext *objectContext = [RKObjectManager sharedManager].managedObjectStore.mainQueueManagedObjectContext;
    
    if (buttonIndex == 1) {
        RKObjectManager *objectManager = [RKObjectManager sharedManager];
        [objectManager.HTTPClient setDefaultHeader:@"Authorization" value:[NSString stringWithFormat:@"Bearer %@", [self accessToken]]];
        [objectManager deleteObject:nil
                               path:[NSString stringWithFormat:@"%@/%@", ORDERS_PATH, _order.orderId]
                         parameters:nil
                            success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                [objectContext deleteObject:_order];
                                [objectContext save:nil];
                                [self.navigationController popViewControllerAnimated:YES];
                            }
                            failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                C4CShowAlertWithError(error);
                            }];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}


@end
