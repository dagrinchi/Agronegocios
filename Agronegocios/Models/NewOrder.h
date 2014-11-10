//
//  NewOrder.h
//  Agronegocios
//
//  Created by David Almeciga on 11/7/14.
//  Copyright (c) 2014 COOL4CODE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewOrder : NSObject

@property (nonatomic, retain) NSNumber * stockId;
@property (nonatomic, retain) NSNumber * qty;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * fullName;
@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * town;
@property (nonatomic, retain) NSString * state;
@property (nonatomic, retain) NSString * country;


@end
