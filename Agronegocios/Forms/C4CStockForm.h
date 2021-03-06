//
//  C4CStockForm.h
//  Agronegocios
//
//  Created by David Almeciga on 9/28/14.
//  Copyright (c) 2014 COOL4CODE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "C4CBlueSubmitButtonCell.h"
#import "C4CNumericCell.h"
#import "Product.h"
#import "Unit.h"

@interface C4CStockForm : NSObject <FXForm, FXModelValidation>

@property (nonatomic, strong) Product *product;
@property (nonatomic, strong) Unit *unit;
@property (nonatomic, strong) NSString *qty;
@property (nonatomic, strong) NSString *pricePerUnit;
@property (nonatomic, strong) NSDate *expiresAt;

- (NSDictionary *)getField :(NSString *) key;

@end
