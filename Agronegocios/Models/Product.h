//
//  Product.h
//  Agronegocios
//
//  Created by David Almeciga on 10/28/14.
//  Copyright (c) 2014 COOL4CODE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Product : NSManagedObject

@property (nonatomic, retain) NSString * code;
@property (nonatomic, retain) NSNumber * productId;
@property (nonatomic, retain) NSString * name;

@end
