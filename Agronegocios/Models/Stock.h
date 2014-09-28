//
//  Stock.h
//  Agronegocios
//
//  Created by David Almeciga on 9/28/14.
//  Copyright (c) 2014 COOL4CODE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class GeoPoint, Product, Unit, User;

@interface Stock : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) NSNumber * qty;
@property (nonatomic, retain) NSNumber * pricePerUnit;
@property (nonatomic, retain) NSDate * expiresAt;
@property (nonatomic, retain) Product *product;
@property (nonatomic, retain) Unit *unit;
@property (nonatomic, retain) GeoPoint *geoPoint;
@property (nonatomic, retain) User *user;

@end
