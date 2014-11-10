//
//  C4CStockDetailTableViewController.m
//  Agronegocios
//
//  Created by David Almeciga on 11/6/14.
//  Copyright (c) 2014 COOL4CODE. All rights reserved.
//

#import "C4CStockDetailTableViewController.h"

@interface C4CStockDetailTableViewController ()
{
    NSArray *stockDetails;
}

@end

@implementation C4CStockDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIColor *bgColor = [UIColor colorWithRed:1 green:0.91 blue:0.74 alpha:1];
    
    self.tableView.backgroundView.backgroundColor = bgColor;
    self.tableView.backgroundColor = bgColor;
    self.refreshControl.backgroundColor = bgColor;
    self.view.backgroundColor = bgColor;
    
    stockDetails = @[@{@"labelText":@"Producto", @"fieldText":_stock.productName},
                     @{@"labelText":@"Unidad", @"fieldText":_stock.unitName},
                     @{@"labelText":@"Cantidad", @"fieldText":[NSNumberFormatter localizedStringFromNumber:_stock.qty numberStyle:NSNumberFormatterDecimalStyle]},
                     @{@"labelText":@"Precio", @"fieldText":[NSNumberFormatter localizedStringFromNumber:_stock.pricePerUnit numberStyle:NSNumberFormatterCurrencyStyle]},
                     @{@"labelText":@"Vence", @"fieldText":[NSDate stringFromDate:_stock.expiresAt withFormat:@"dd MMM YYYY"]},
                     @{@"labelText":@"Ubicación", @"fieldText":[NSString stringWithFormat:@"%@, %@, %@ - %@", _stock.address, _stock.town, _stock.state, _stock.country]},
                     @{@"labelText":@"Productor", @"fieldText":_stock.userName},
                     @{@"labelText":@"Email", @"fieldText":_stock.userEmail}];
    
    self.title = _stock.productName;
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
    return section == 1 ? 1 : [stockDetails count];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = self.tableView.backgroundColor = [UIColor colorWithRed:1 green:0.91 blue:0.74 alpha:1];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (indexPath.section == 0) {
        cell = (UITableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:@"stockCell"];
        
        NSDictionary *stockDetail = nil;
        stockDetail = [stockDetails objectAtIndex:indexPath.row];
        
        [cell.textLabel setText:stockDetail[@"labelText"]];
        [cell.detailTextLabel setText:stockDetail[@"fieldText"]];
        
        UIView *selectedBackgroupdView = [[UIView alloc] init];
        selectedBackgroupdView.backgroundColor = [UIColor colorWithRed:1 green:0.27 blue:0.27 alpha:0.3];
        [cell setSelectedBackgroundView:selectedBackgroupdView];
        
    } else if (indexPath.section == 1) {
        cell = (UITableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:@"buttonCell"];
    }
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"stockCell"];
    }
    
    return cell;
}

#pragma mark

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (IBAction)buyAction:(id)sender {
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"newOrderSegue"]) {
        C4CNewOrderFormViewController *newOrderFormViewController = segue.destinationViewController;
        newOrderFormViewController.stock = _stock;
    }
}


@end
