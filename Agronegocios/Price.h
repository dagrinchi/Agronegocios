//
//  Price.h
//  Agronegocios
//
//  Created by David Almeciga on 10/21/14.
//  Copyright (c) 2014 COOL4CODE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Price : NSManagedObject

@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) NSNumber * priceAvgPerUnit;
@property (nonatomic, retain) NSNumber * priceId;
@property (nonatomic, retain) NSNumber * priceMaxPerUnit;
@property (nonatomic, retain) NSNumber * priceMinPerUnit;
@property (nonatomic, retain) NSDate * updatedAt;
@property (nonatomic, retain) NSString * productCode;
@property (nonatomic, retain) NSString * productName;
@property (nonatomic, retain) NSString * unitCode;
@property (nonatomic, retain) NSString * unitName;

@end
