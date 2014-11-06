//
//  C4CUnitTableViewController.h
//  Agronegocios
//
//  Created by David Almeciga on 11/5/14.
//  Copyright (c) 2014 COOL4CODE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Token.h"
#import "Unit.h"

@interface C4CUnitTableViewController : UITableViewController <FXFormFieldViewController, NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) FXFormField *field;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@end
