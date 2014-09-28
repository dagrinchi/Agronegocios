//
//  User.h
//  Agronegocios
//
//  Created by David Almeciga on 9/28/14.
//  Copyright (c) 2014 COOL4CODE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class MyOrders, MyPurchases;

@interface User : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) NSSet *myOrders;
@property (nonatomic, retain) NSSet *myPurchases;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addMyOrdersObject:(MyOrders *)value;
- (void)removeMyOrdersObject:(MyOrders *)value;
- (void)addMyOrders:(NSSet *)values;
- (void)removeMyOrders:(NSSet *)values;

- (void)addMyPurchasesObject:(MyPurchases *)value;
- (void)removeMyPurchasesObject:(MyPurchases *)value;
- (void)addMyPurchases:(NSSet *)values;
- (void)removeMyPurchases:(NSSet *)values;

@end
