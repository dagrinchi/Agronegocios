//
//  C4CPriceTableViewController.h
//  Agronegocios
//
//  Created by David Almeciga on 10/19/14.
//  Copyright (c) 2014 COOL4CODE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>
#import <RestKit/Search.h>
#import "C4CRootFormViewController.h"
#import "C4CWhoamiTableViewController.h"
#import "C4CPriceTableViewCell.h"
#import "C4CPriceDetailTableViewController.h"
#import "C4CAppDelegate.h"
#import "Price.h"
#import "Token.h"

@interface C4CPriceTableViewController : UITableViewController

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSFetchedResultsController *searchFetchedResultsController;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *loginButton;

@end
