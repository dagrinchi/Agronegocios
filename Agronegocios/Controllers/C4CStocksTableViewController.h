//
//  C4CStocksTableViewController.h
//  Agronegocios
//
//  Created by David Almeciga on 11/2/14.
//  Copyright (c) 2014 COOL4CODE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/Search.h>
#import "C4CStockTableViewCell.h"
#import "C4CStockDetailTableViewController.h"
#import "Token.h"
#import "Stock.h"

@interface C4CStocksTableViewController : UITableViewController

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSFetchedResultsController *searchFetchedResultsController;

@end
