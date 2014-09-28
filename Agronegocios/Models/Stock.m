//
//  Stock.m
//  Agronegocios
//
//  Created by David Almeciga on 9/28/14.
//  Copyright (c) 2014 COOL4CODE. All rights reserved.
//

#import "Stock.h"
#import "GeoPoint.h"
#import "Product.h"
#import "Unit.h"
#import "User.h"


@implementation Stock

@dynamic id;
@dynamic createdAt;
@dynamic qty;
@dynamic pricePerUnit;
@dynamic expiresAt;
@dynamic product;
@dynamic unit;
@dynamic geoPoint;
@dynamic user;

@end
