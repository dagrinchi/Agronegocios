//
//  C4CWhoamiTableViewController.m
//  Agronegocios
//
//  Created by David Almeciga on 11/2/14.
//  Copyright (c) 2014 COOL4CODE. All rights reserved.
//

#import "C4CWhoamiTableViewController.h"

@interface C4CWhoamiTableViewController ()

@end

@implementation C4CWhoamiTableViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor colorWithRed:1 green:0.91 blue:0.74 alpha:1];
    self.title = @"¿Quién soy?";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = self.tableView.backgroundColor = [UIColor colorWithRed:1 green:0.91 blue:0.74 alpha:1];
}

- (IBAction)unwindFarmer:(UIStoryboardSegue *)segue {
    
}

- (IBAction)unwindCustomer:(UIStoryboardSegue *)segue {
    
}

@end
