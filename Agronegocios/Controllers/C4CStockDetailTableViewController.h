//
//  C4CStockDetailTableViewController.h
//  Agronegocios
//
//  Created by David Almeciga on 11/6/14.
//  Copyright (c) 2014 COOL4CODE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Stock.h"
#import "C4CNewOrderFormViewController.h"

@interface C4CStockDetailTableViewController : UITableViewController

@property (nonatomic, strong) Stock *stock;

@end
