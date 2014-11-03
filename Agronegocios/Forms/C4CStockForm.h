//
//  C4CStockForm.h
//  Agronegocios
//
//  Created by David Almeciga on 9/28/14.
//  Copyright (c) 2014 COOL4CODE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "C4CSubmitButtonCell.h"
#import "Product.h"
#import "Unit.h"

@interface C4CStockForm : NSObject <FXForm>

@property (nonatomic, copy) Product *product;
@property (nonatomic, copy) Unit *unit;
@property (nonatomic, copy) NSNumber *qty;
@property (nonatomic, copy) NSNumber *pricePerUnit;
@property (nonatomic, copy) NSDate *expiresAt;

@property (nonatomic, copy) NSArray *units;
@property (nonatomic, copy) NSArray *products;

@end
