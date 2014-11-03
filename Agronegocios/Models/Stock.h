//
//  Stock.h
//  Agronegocios
//
//  Created by David Almeciga on 11/3/14.
//  Copyright (c) 2014 COOL4CODE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Stock : NSManagedObject

@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) NSDate * expiresAt;
@property (nonatomic, retain) NSNumber * stockId;
@property (nonatomic, retain) NSNumber * pricePerUnit;
@property (nonatomic, retain) NSNumber * qty;
@property (nonatomic, retain) NSString * productCode;
@property (nonatomic, retain) NSString * productName;
@property (nonatomic, retain) NSNumber * productId;
@property (nonatomic, retain) NSString * unitCode;
@property (nonatomic, retain) NSString * unitName;
@property (nonatomic, retain) NSNumber * unitId;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * town;
@property (nonatomic, retain) NSString * state;
@property (nonatomic, retain) NSString * country;
@property (nonatomic, retain) NSString * userEmail;
@property (nonatomic, retain) NSString * userPhone;
@property (nonatomic, retain) NSString * userIdentification;
@property (nonatomic, retain) NSString * userName;
@property (nonatomic, retain) NSDate * updatedAt;

@end
