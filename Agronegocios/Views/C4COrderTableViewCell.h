//
//  C4COrderTableViewCell.h
//  Agronegocios
//
//  Created by David Almeciga on 11/7/14.
//  Copyright (c) 2014 COOL4CODE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface C4COrderTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *productName;
@property (strong, nonatomic) IBOutlet UILabel *userName;
@property (strong, nonatomic) IBOutlet UILabel *expiresAt;
@property (strong, nonatomic) IBOutlet UILabel *pricePerUnit;
@property (strong, nonatomic) IBOutlet UILabel *qty;
@property (strong, nonatomic) IBOutlet UILabel *unitName;


@end
