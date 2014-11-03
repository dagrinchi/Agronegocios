//
//  GeoCode.h
//  Agronegocios
//
//  Created by David Almeciga on 11/2/14.
//  Copyright (c) 2014 COOL4CODE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddressComponent.h"

@interface GeoCode : NSObject

@property (nonatomic, copy) NSString * formattedAddress;
@property (nonatomic, copy) NSArray * addressComponents;

@end