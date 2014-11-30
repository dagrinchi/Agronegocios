//
//  C4CLoginForm.m
//  Agronegocios
//
//  Created by David Almeciga on 9/28/14.
//  Copyright (c) 2014 COOL4CODE. All rights reserved.
//

#import "C4CLoginForm.h"
#import "C4CGreenSubmitButtonCell.h"

@implementation C4CLoginForm

-(instancetype) init {
    if((self = [super init])) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            [[self class] validationInit];
        });
    }
    
    return self;
}

- (NSArray *)fields {
    return @[@{FXFormFieldKey: @"identification",
               FXFormFieldTitle: @"No. identificación",
               @"textLabel.font": [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:18.0]},
             @{FXFormFieldKey: @"password",
               FXFormFieldTitle: @"Clave",
               FXFormFieldType : FXFormFieldTypePassword,
               @"textLabel.font": [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:18.0]}];
}

- (NSArray *)extraFields
{
    return @[@{FXFormFieldCell: [C4CGreenSubmitButtonCell class],
               FXFormFieldHeader: @"",
               FXFormFieldAction: @"submitLoginForm:"}];
}

-(NSArray *)rules {
    return @[@{FXModelValidatorAttributes : @[@"identification", @"password"],
               FXModelValidatorType : @"required",
               FXModelValidatorOn: @[@"login"]},
             
             @{FXModelValidatorAttributes : @[@"identification"],
               FXModelValidatorType : @"match",
               FXModelValidatorPattern : @"^[a-zA-Z0-9]*$",
               FXModelValidatorOn: @[@"login"]},
             
             @{FXModelValidatorAttributes : @[@"identification"],
               FXModelValidatorType : @"string",
               FXModelValidatorMin : @6,
               FXModelValidatorOn: @[@"login"]},
             
             @{FXModelValidatorAttributes : @[@"password"],
               FXModelValidatorType : @"match",
               FXModelValidatorPattern : @"^[0-9]*$",
               FXModelValidatorOn: @[@"login"]},
             
             @{FXModelValidatorAttributes : @[@"password"],
               FXModelValidatorType : @"string",
               FXModelValidatorLength : @4,
               FXModelValidatorOn: @[@"login"]}];
    
}

@end