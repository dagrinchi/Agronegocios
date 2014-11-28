//
//  C4CTermsTableViewController.m
//  Agronegocios
//
//  Created by David Almeciga on 11/27/14.
//  Copyright (c) 2014 COOL4CODE. All rights reserved.
//

#import "C4CTermsTableViewController.h"

@interface C4CTermsTableViewController ()
{
    CGFloat height;
}

@end

@implementation C4CTermsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor colorWithRed:1 green:0.91 blue:0.74 alpha:1];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    height = CGRectGetHeight(self.view.bounds) - 64;
}

- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    height = CGRectGetHeight(self.view.bounds);
    [self.tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cellHeight = height - 130;
    if (indexPath.section == 0) {
        return cellHeight < 360 ? 360 : cellHeight;
    }
    
    return 44;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = self.tableView.backgroundColor = [UIColor colorWithRed:1 green:0.91 blue:0.74 alpha:1];
}

@end
