//
//  C4CPriceTableViewCell.h
//  Agronegocios
//
//  Created by David Almeciga on 10/23/14.
//  Copyright (c) 2014 COOL4CODE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface C4CPriceTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *productName;
@property (weak, nonatomic) IBOutlet UILabel *location;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *unit;
@property (weak, nonatomic) IBOutlet UILabel *createDate;


@end
