//
//  C4CRegistrationForm.m
//  Agronegocios
//
//  Created by David Almeciga on 9/28/14.
//  Copyright (c) 2014 COOL4CODE. All rights reserved.
//

#import "C4CRegistrationForm.h"
#import "C4CGreenSubmitButtonCell.h"

@implementation C4CRegistrationForm

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
    return @[@{FXFormFieldKey: @"name",
               FXFormFieldHeader: @"Información Básica",
               FXFormFieldTitle: @"Nombre completo",
               @"textLabel.font": [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:18.0],
               @"textField.autocapitalizationType": @(UITextAutocapitalizationTypeWords)},
             @{FXFormFieldKey: @"identification",
               FXFormFieldTitle: @"No. identificación",
               @"textLabel.font": [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:18.0]},
             @{FXFormFieldKey: @"phone",
               @"textLabel.font": [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:18.0],
               FXFormFieldTitle: @"No. móvil"},
             @{FXFormFieldKey: @"email",
               @"textLabel.font": [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:18.0],
               FXFormFieldTitle: @"E-mail"},
             @{FXFormFieldKey: @"address",
               @"textLabel.font": [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:18.0],
               FXFormFieldTitle: @"Dirección domicilio"},
             @{FXFormFieldKey: @"password",
               @"textLabel.font": [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:18.0],
               FXFormFieldTitle: @"Clave",
               @"textLabel.font": [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:18.0],
               FXFormFieldHeader: @"Usa 4 dígitos como clave"},
             @{FXFormFieldKey: @"repeatPassword",
               @"textLabel.font": [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:18.0],
               FXFormFieldTitle: @"Re-clave"}];
}

- (NSArray *)extraFields
{
    return @[@{FXFormFieldCell: [C4CGreenSubmitButtonCell class],
               FXFormFieldTitle: @"Enviar",
               FXFormFieldHeader: @"",
               FXFormFieldAction: @"submitRegistrationForm:"}];
}

-(NSArray *)rules {
    return @[@{FXModelValidatorAttributes : @[@"name", @"identification", @"phone", @"email", @"address", @"password", @"repeatPassword"],
               FXModelValidatorType : @"required",
               FXModelValidatorOn: @[@"register"]},
             
             @{FXModelValidatorAttributes : @[@"name"],
               FXModelValidatorType : @"string",
               FXModelValidatorMin : @8,
               FXModelValidatorOn: @[@"register"]},
             
             @{FXModelValidatorAttributes : @[@"identification"],
               FXModelValidatorType : @"match",
               FXModelValidatorPattern : @"^[a-zA-Z0-9]*$",
               FXModelValidatorOn: @[@"register"]},
             
             @{FXModelValidatorAttributes : @[@"identification"],
               FXModelValidatorType : @"string",
               FXModelValidatorMin : @6,
               FXModelValidatorOn: @[@"register"]},
             
             @{FXModelValidatorAttributes : @[@"phone"],
               FXModelValidatorType : @"match",
               FXModelValidatorPattern : @"^[0-9]*$",
               FXModelValidatorOn: @[@"register"]},
             
             @{FXModelValidatorAttributes : @[@"phone"],
               FXModelValidatorType : @"string",
               FXModelValidatorLength : @[@7, @10],
               FXModelValidatorOn: @[@"register"]},
             
             @{FXModelValidatorAttributes : @[@"email"],
               FXModelValidatorType : @"email",
               FXModelValidatorOn: @[@"register"]},
             
             @{FXModelValidatorAttributes : @[@"password"],
               FXModelValidatorType : @"match",
               FXModelValidatorPattern : @"^[0-9]*$",
               FXModelValidatorOn: @[@"register"]},
             
             @{FXModelValidatorAttributes : @[@"password"],
               FXModelValidatorType : @"string",
               FXModelValidatorLength : @4,
               FXModelValidatorOn: @[@"register"]},
             
             @{FXModelValidatorAttributes : @[@"repeatPassword"],
               FXModelValidatorType : @"compare",
               FXModelValidatorCompareAttribute : @"password",
               FXModelValidatorOn: @[@"register"]}];
    
}


@end
