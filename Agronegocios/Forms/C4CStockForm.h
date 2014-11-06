//
//  C4CStockForm.h
//  Agronegocios
//
//  Created by David Almeciga on 9/28/14.
//  Copyright (c) 2014 COOL4CODE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "C4CBlueSubmitButtonCell.h"
#import "Product.h"
#import "Unit.h"

@interface C4CStockForm : NSObject <FXForm>

@property (nonatomic, strong) Product *product;
@property (nonatomic, strong) Unit *unit;
@property (nonatomic, strong) NSNumber *qty;
@property (nonatomic, strong) NSNumber *pricePerUnit;
@property (nonatomic, strong) NSDate *expiresAt;

@end
