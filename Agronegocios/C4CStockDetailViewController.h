//
//  C4CStockDetailViewController.h
//  Agronegocios
//
//  Created by David Almeciga on 7/9/14.
//  Copyright (c) 2014 COOL4CODE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "C4CLabel.h"

@interface C4CStockDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet C4CLabel *code;
@property (weak, nonatomic) IBOutlet C4CLabel *name;
@property (weak, nonatomic) IBOutlet C4CLabel *qty;
@property (weak, nonatomic) IBOutlet C4CLabel *unit;
@property (weak, nonatomic) IBOutlet C4CLabel *value;
@property (weak, nonatomic) IBOutlet C4CLabel *total;
@property (weak, nonatomic) IBOutlet C4CLabel *location;

@end
