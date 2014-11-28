//
//  C4CWhoamiTableViewController.m
//  Agronegocios
//
//  Created by David Almeciga on 11/2/14.
//  Copyright (c) 2014 COOL4CODE. All rights reserved.
//

#import "C4CWhoamiTableViewController.h"

@interface C4CWhoamiTableViewController ()
{
    CGFloat height;
}

@end

@implementation C4CWhoamiTableViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor colorWithRed:1 green:0.91 blue:0.74 alpha:1];
    self.title = @"¿Quién soy?";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Atras"
                                                                   style:UIBarButtonItemStyleBordered
                                                                  target:self
                                                                  action:@selector(backHome)];
    self.navigationItem.leftBarButtonItem = backButton;
    /*self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cerrar sesión" style:UIBarButtonItemStylePlain target:nil action:[self logoutAction:]];*/
    
    height = CGRectGetHeight(self.view.bounds) - 64;

}

- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    height = CGRectGetHeight(self.view.bounds);
    [self.tableView reloadData];
}

-(void)backHome {
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = self.tableView.backgroundColor = [UIColor colorWithRed:1 green:0.91 blue:0.74 alpha:1];
    if (indexPath.section == 2 && indexPath.item == 0) {
        cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"facebook-24"]];
    } else if (indexPath.section == 2 && indexPath.item == 1) {
        cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"twitter-24"]];
    } else if (indexPath.section == 2 && indexPath.item == 2) {
        cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"about-24"]];
    }
    
    UIView *selectedBackgroupdView = [[UIView alloc] init];
    selectedBackgroupdView.backgroundColor = [UIColor colorWithRed:0.4 green:0.6 blue:0 alpha:0.1];
    [cell setSelectedBackgroundView:selectedBackgroupdView];
}

- (IBAction)unwindFarmer:(UIStoryboardSegue *)segue {
    
}

- (IBAction)unwindCustomer:(UIStoryboardSegue *)segue {
    
}

- (IBAction)logoutAction:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"¿Desea countinar?"
                                                    message:@"Va a cerrar sesión"
                                                   delegate:self
                                          cancelButtonTitle:@"Cancelar"
                                          otherButtonTitles:@"Continuar", nil];
    [alert show];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cellHeight = (height / 2) - 130;
    if (indexPath.section == 0) {
        return cellHeight < 240 ? 240 : cellHeight;
    }
    
    return 44;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        NSError *error = nil;
        NSManagedObjectContext *objectContext = [RKObjectManager sharedManager].managedObjectStore.mainQueueManagedObjectContext;
        
        // TOKENS
        NSArray *tokens = [objectContext executeFetchRequest:[[NSFetchRequest alloc] initWithEntityName:@"Token"] error:&error];
        for (Token *token in tokens) {
            [objectContext deleteObject:token];
        }
        
        // MY ORDERS
        NSArray *myOrders = [objectContext executeFetchRequest:[[NSFetchRequest alloc] initWithEntityName:@"MyOrders"] error:&error];
        for (MyOrders *myOrder in myOrders) {
            [objectContext deleteObject:myOrder];
        }
        
        // MY PURCHASES
        NSArray *myPurchases = [objectContext executeFetchRequest:[[NSFetchRequest alloc] initWithEntityName:@"MyPurchases"] error:&error];
        for (MyPurchases *myPurchase in myPurchases) {
            [objectContext deleteObject:myPurchase];
        }
        
        // MY STOCKS
        NSArray *myStocks = [objectContext executeFetchRequest:[[NSFetchRequest alloc] initWithEntityName:@"MyStock"] error:&error];
        for (MyStock *myStock in myStocks) {
            [objectContext deleteObject:myStock];
        }
        
        [objectContext save:&error];
        [self backHome];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
