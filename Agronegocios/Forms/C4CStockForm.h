//
//  C4CStockForm.h
//  Agronegocios
//
//  Created by David Almeciga on 9/28/14.
//  Copyright (c) 2014 COOL4CODE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Product.h"

@interface C4CStockForm : NSObject <FXForm>

@property (nonatomic, copy) Product *product;

@end
