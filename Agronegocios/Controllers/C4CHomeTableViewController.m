//
//  C4CHomeTableViewController.m
//  Agronegocios
//
//  Created by David Almeciga on 8/25/14.
//  Copyright (c) 2014 COOL4CODE. All rights reserved.
//

#import "C4CHomeTableViewController.h"

@interface C4CHomeTableViewController ()
{
    CGFloat height;
}

@end

@implementation C4CHomeTableViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor colorWithRed:1 green:0.91 blue:0.74 alpha:1];
    self.title = @"Agronegocios";
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
    CGFloat cellHeight = height - 200;
    if (indexPath.section == 0) {
        return cellHeight < 300 ? 300 : cellHeight;
    }
    
    return 44;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = self.tableView.backgroundColor = [UIColor colorWithRed:1 green:0.91 blue:0.74 alpha:1];
}

- (IBAction)unwindTerms:(UIStoryboardSegue *)segue {

}

- (IBAction)unwindHelp:(UIStoryboardSegue *)segue {
    
}

- (IBAction)unwindTermsAndAccept:(UIStoryboardSegue *)segue {
    /*NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    BOOL is_accept_terms = [userDefaults boolForKey:@"is_accept_terms"];
    if (!is_accept_terms) {
        [userDefaults setBool:true forKey:@"is_accept_terms"];
        [userDefaults synchronize];
    }*/
}

- (IBAction)startAction:(id)sender {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    C4CPriceTableViewController *priceTableViewController = [storyBoard instantiateViewControllerWithIdentifier:@"pricesView"];
    [self.navigationController pushViewController:priceTableViewController animated:YES];
    
    /*
     UINavigationController *termsNavigationController = [storyBoard instantiateViewControllerWithIdentifier:@"termsView"];
     NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    BOOL is_accept_terms = [userDefaults boolForKey:@"is_accept_terms"];
    if (is_accept_terms) {
        [self.navigationController pushViewController:priceTableViewController animated:YES];
    } else {
        [self presentViewController:termsNavigationController animated:YES completion:NULL];
    }*/
}

@end
