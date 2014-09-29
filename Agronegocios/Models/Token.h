//
//  Token.h
//  Agronegocios
//
//  Created by David Almeciga on 9/28/14.
//  Copyright (c) 2014 COOL4CODE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Token : NSManagedObject

@property (nonatomic, retain) NSDate * expiresAt;
@property (nonatomic, retain) NSDate * issuedAt;
@property (nonatomic, retain) NSString * accessToken;
@property (nonatomic, retain) NSNumber * expiresIn;
@property (nonatomic, retain) NSString * tokenType;
@property (nonatomic, retain) NSString * userName;

@end
