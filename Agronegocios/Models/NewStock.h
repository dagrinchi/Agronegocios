//
//  NewStock.h
//  Agronegocios
//
//  Created by David Almeciga on 11/3/14.
//  Copyright (c) 2014 COOL4CODE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewStock : NSObject

@property (nonatomic, retain) NSNumber * productId;
@property (nonatomic, retain) NSNumber * unitId;
@property (nonatomic, retain) NSNumber * qty;
@property (nonatomic, retain) NSNumber * pricePerUnit;
@property (nonatomic, retain) NSDate * expiresAt;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * town;
@property (nonatomic, retain) NSString * state;
@property (nonatomic, retain) NSString * country;

@end
