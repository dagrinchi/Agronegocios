//
//  C4CImageTableViewCell.h
//  Agronegocios
//
//  Created by David Almeciga on 7/8/14.
//  Copyright (c) 2014 COOL4CODE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "C4CLabel.h"

@interface C4CImageTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet C4CLabel *code;
@property (weak, nonatomic) IBOutlet C4CLabel *name;
@property (weak, nonatomic) IBOutlet C4CLabel *location;
@property (weak, nonatomic) IBOutlet C4CLabel *qty;
@property (weak, nonatomic) IBOutlet C4CLabel *value;
@property (weak, nonatomic) IBOutlet C4CLabel *total;
@property (weak, nonatomic) IBOutlet C4CLabel *unit;


@end
