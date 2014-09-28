//
//  MyPurchases.h
//  Agronegocios
//
//  Created by David Almeciga on 9/28/14.
//  Copyright (c) 2014 COOL4CODE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class GeoPoint, Stock, User;

@interface MyPurchases : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * fullName;
@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) NSNumber * qty;
@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) GeoPoint *geoPoint;
@property (nonatomic, retain) Stock *stock;
@property (nonatomic, retain) User *user;

@end
