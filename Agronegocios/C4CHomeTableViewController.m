//
//  C4CHomeTableViewController.m
//  Agronegocios
//
//  Created by David Almeciga on 8/25/14.
//  Copyright (c) 2014 COOL4CODE. All rights reserved.
//

#import "C4CHomeTableViewController.h"

@interface C4CHomeTableViewController ()

@end

@implementation C4CHomeTableViewController

- (IBAction)unwindList:(UIStoryboardSegue *)segue {
    
}

- (void) viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor colorWithRed:1 green:0.91 blue:0.74 alpha:1];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = self.tableView.backgroundColor = [UIColor colorWithRed:1 green:0.91 blue:0.74 alpha:1];
}
@end
