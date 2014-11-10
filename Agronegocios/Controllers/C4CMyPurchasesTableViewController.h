//
//  C4CMyPurchasesTableViewController.h
//  Agronegocios
//
//  Created by David Almeciga on 11/2/14.
//  Copyright (c) 2014 COOL4CODE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/Search.h>
#import "C4COrderTableViewCell.h"
#import "C4CMyPurchasesDetailTableViewController.h"
#import "MyPurchases.h"
#import "Token.h"

@interface C4CMyPurchasesTableViewController : UITableViewController

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSFetchedResultsController *searchFetchedResultsController;

@end
