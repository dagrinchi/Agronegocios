//
//  C4CRegistrationForm.h
//  Agronegocios
//
//  Created by David Almeciga on 9/28/14.
//  Copyright (c) 2014 COOL4CODE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "C4CGreenSubmitButtonCell.h"
#import "C4CPasswordCell.h"

@interface C4CRegistrationForm : NSObject <FXForm, FXModelValidation>

@property (nonatomic, copy) NSString *identification;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *repeatPassword;

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *address;

- (NSDictionary *)getField :(NSString *) key;

@end
