//
//  C4CStockTableViewController.m
//  Agronegocios
//
//  Created by David Almeciga on 8/9/14.
//  Copyright (c) 2014 COOL4CODE. All rights reserved.
//

#import "C4CStockTableViewController.h"
#import "C4CImageTableViewCell.h"

@interface C4CStockTableViewController ()
{
    NSArray *stockData;
    NSArray *searchResults;
}


@end

@implementation C4CStockTableViewController

- (IBAction)unwindLogin:(UIStoryboardSegue *)segue {
    
}

- (void) viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundView  = nil;
    self.tableView.backgroundColor = [UIColor colorWithRed:1 green:0.91 blue:0.74 alpha:1];
    
    stockData = @[
                  @{@"imagen": @"papa.png", @"codigo": @"P001", @"nombre": @"Papa pastusa", @"ubicacion": @"Chocontá", @"cantidad": @"20", @"valor": @"60000", @"total": @"1200000", @"unidad": @"CARG"},
                  @{@"imagen": @"fresa.png", @"codigo": @"A002", @"nombre": @"Arracacha", @"ubicacion": @"Chocontá", @"cantidad": @"20", @"valor": @"60000", @"total": @"1200000", @"unidad": @"CARG"},
                  @{@"imagen": @"papa.png", @"codigo": @"F001", @"nombre": @"Fresa", @"ubicacion": @"Chocontá", @"cantidad": @"20", @"valor": @"60000", @"total": @"1200000", @"unidad": @"CARG"},
                  @{@"imagen": @"fresa.png", @"codigo": @"PI01", @"nombre": @"Piña", @"ubicacion": @"Chocontá", @"cantidad": @"20", @"valor": @"60000", @"total": @"1200000", @"unidad": @"CARG"},
                  @{@"imagen": @"papa.png", @"codigo": @"UV01", @"nombre": @"Uva", @"ubicacion": @"Chocontá", @"cantidad": @"20", @"valor": @"60000", @"total": @"1200000", @"unidad": @"CARG"},
                  @{@"imagen": @"fresa.png", @"codigo": @"PE01", @"nombre": @"Pera", @"ubicacion": @"Chocontá", @"cantidad": @"20", @"valor": @"60000", @"total": @"1200000", @"unidad": @"CARG"},
                  @{@"imagen": @"papa.png", @"codigo": @"BA01", @"nombre": @"Banano", @"ubicacion": @"Chocontá", @"cantidad": @"20", @"valor": @"60000", @"total": @"1200000", @"unidad": @"CARG"},
                  @{@"imagen": @"fresa.png", @"codigo": @"CO01", @"nombre": @"Coco", @"ubicacion": @"Chocontá", @"cantidad": @"20", @"valor": @"60000", @"total": @"1200000", @"unidad": @"CARG"},
                  @{@"imagen": @"papa.png", @"codigo": @"KI01", @"nombre": @"Kiwi", @"ubicacion": @"Chocontá", @"cantidad": @"20", @"valor": @"60000", @"total": @"1200000", @"unidad": @"CARG"},
                  @{@"imagen": @"fresa.png", @"codigo": @"MO01", @"nombre": @"Mora", @"ubicacion": @"Chocontá", @"cantidad": @"20", @"valor": @"60000", @"total": @"1200000", @"unidad": @"CARG"}
                ];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [stockData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    C4CImageTableViewCell *stockCell = [tableView dequeueReusableCellWithIdentifier:@"stockCell"];
    NSDictionary* dict = stockData[indexPath.row];
    
    [stockCell.code setText:dict[@"codigo"]];
    [stockCell.name setText:dict[@"nombre"]];
    stockCell.imageView.image = [UIImage imageNamed:dict[@"imagen"]];
    [stockCell.qty setText:dict[@"cantidad"]];
    [stockCell.value setText:dict[@"valor"]];
    [stockCell.total setText:dict[@"total"]];
    [stockCell.unit setText:dict[@"unidad"]];
    
    return stockCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 71;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = self.tableView.backgroundColor = [UIColor colorWithRed:1 green:0.91 blue:0.74 alpha:1];
}

- (void)filterContentForSearchText:(NSString *)searchText scope:(NSString *)scope {
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"name contains[c] %@", searchText];
    searchResults = [stockData filteredArrayUsingPredicate:resultPredicate];
}

//- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
//{
//    [self filterContentForSearchText:searchString scope:[[self searchDisplayController.searchBar selected]]
//}

@end
