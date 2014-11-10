//
//  C4CPriceDetailTableViewController.m
//  Agronegocios
//
//  Created by David Almeciga on 11/9/14.
//  Copyright (c) 2014 COOL4CODE. All rights reserved.
//

#import "C4CPriceDetailTableViewController.h"

@interface C4CPriceDetailTableViewController ()
{
    NSArray * priceDetails;
}

@end

@implementation C4CPriceDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIColor *bgColor = [UIColor colorWithRed:1 green:0.91 blue:0.74 alpha:1];
    
    self.tableView.backgroundView.backgroundColor = bgColor;
    self.tableView.backgroundColor = bgColor;
    self.refreshControl.backgroundColor = bgColor;
    self.view.backgroundColor = bgColor;
    
    priceDetails = @[@{@"labelText":@"Producto", @"fieldText":_price.productName},
                     @{@"labelText":@"Unidad", @"fieldText":_price.unitName},
                     @{@"labelText":@"Precio Máximo", @"fieldText":[NSNumberFormatter localizedStringFromNumber:_price.priceMaxPerUnit numberStyle:NSNumberFormatterCurrencyStyle]},
                     @{@"labelText":@"Precio Promedio", @"fieldText":[NSNumberFormatter localizedStringFromNumber:_price.priceAvgPerUnit numberStyle:NSNumberFormatterCurrencyStyle]},
                     @{@"labelText":@"Precio Mínimo", @"fieldText":[NSNumberFormatter localizedStringFromNumber:_price.priceMinPerUnit numberStyle:NSNumberFormatterCurrencyStyle]},
                     @{@"labelText":@"Mercado", @"fieldText":_price.location},
                     @{@"labelText":@"Fecha", @"fieldText":[NSDate stringFromDate:_price.createdAt withFormat:@"dd MMM YYYY"]},];
    
    self.title = _price.productName;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Atras" style:UIBarButtonItemStylePlain target:nil action:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [priceDetails count];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = self.tableView.backgroundColor = [UIColor colorWithRed:1 green:0.91 blue:0.74 alpha:1];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    cell = (UITableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:@"priceCell"];
    
    NSDictionary *priceDetail = nil;
    priceDetail = [priceDetails objectAtIndex:indexPath.row];
    
    [cell.textLabel setText:priceDetail[@"labelText"]];
    [cell.detailTextLabel setText:priceDetail[@"fieldText"]];
    
    UIView *selectedBackgroupdView = [[UIView alloc] init];
    selectedBackgroupdView.backgroundColor = [UIColor colorWithRed:1 green:0.27 blue:0.27 alpha:0.3];
    [cell setSelectedBackgroundView:selectedBackgroupdView];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"priceCell"];
    }
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

@end
