//
//  C4CProductTableViewController.h
//  Agronegocios
//
//  Created by David Almeciga on 11/5/14.
//  Copyright (c) 2014 COOL4CODE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/Search.h>
#import "Token.h"
#import "Product.h"

@interface C4CProductTableViewController : UITableViewController <FXFormFieldViewController, NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) FXFormField *field;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSFetchedResultsController *searchFetchedResultsController;

@end
