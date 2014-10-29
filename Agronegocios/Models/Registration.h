//
//  Registration.h
//  Agronegocios
//
//  Created by David Almeciga on 10/28/14.
//  Copyright (c) 2014 COOL4CODE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Registration : NSObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * identification;
@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSString * repeatPassword;

@end
