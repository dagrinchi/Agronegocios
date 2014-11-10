//
//  MyOrders.h
//  Agronegocios
//
//  Created by David Almeciga on 11/7/14.
//  Copyright (c) 2014 COOL4CODE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface MyOrders : NSManagedObject

@property (nonatomic, retain) NSString * fullName;
@property (nonatomic, retain) NSNumber * orderId;
@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) NSNumber * stockQty;
@property (nonatomic, retain) NSNumber * stockId;
@property (nonatomic, retain) NSNumber * orderLatitude;
@property (nonatomic, retain) NSNumber * orderLongitude;
@property (nonatomic, retain) NSNumber * pricePerUnit;
@property (nonatomic, retain) NSNumber * orderQty;
@property (nonatomic, retain) NSString * orderAddress;
@property (nonatomic, retain) NSString * orderCountry;
@property (nonatomic, retain) NSString * productCode;
@property (nonatomic, retain) NSString * productName;
@property (nonatomic, retain) NSString * orderState;
@property (nonatomic, retain) NSString * orderTown;
@property (nonatomic, retain) NSString * unitCode;
@property (nonatomic, retain) NSString * unitName;
@property (nonatomic, retain) NSString * userEmail;
@property (nonatomic, retain) NSString * userIdentification;
@property (nonatomic, retain) NSString * userName;
@property (nonatomic, retain) NSString * userPhone;
@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) NSDate * expiresAt;
@property (nonatomic, retain) NSDate * updatedAt;
@property (nonatomic, retain) NSNumber * stockLatitude;
@property (nonatomic, retain) NSNumber * stockLongitude;
@property (nonatomic, retain) NSString * stockAddress;
@property (nonatomic, retain) NSString * stockTown;
@property (nonatomic, retain) NSString * stockState;
@property (nonatomic, retain) NSString * stockCountry;
@property (nonatomic, retain) NSString * stockUserEmail;
@property (nonatomic, retain) NSString * stockUserName;
@property (nonatomic, retain) NSString * stockUserPhone;
@property (nonatomic, retain) NSString * stockUserIdentification;

@end
