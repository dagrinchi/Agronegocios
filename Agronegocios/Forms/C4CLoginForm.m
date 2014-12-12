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

- (NSDictionary *)getField :(NSString *) key
{
    for (NSDictionary *obj in self.fields) {
        if ([obj objectForKey:@"key"] == key){
            return obj;
        }
    }
    
    return nil;
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
    return @[@{FXFormFieldHeader: @"",
               FXFormFieldTitle: @"Ingresar",
               FXFormFieldCell: [C4CGreenSubmitButtonCell class],
               FXFormFieldAction: @"submitLoginForm:"}];
}

-(NSArray *)rules {
    return @[@{FXModelValidatorAttributes : @[@"identification", @"password"],
               FXModelValidatorType : @"required",
               FXModelValidatorMessage: @"es requerido",
               FXModelValidatorOn: @[@"login"]},
             
             @{FXModelValidatorAttributes : @[@"identification"],
               FXModelValidatorType : @"match",
               FXModelValidatorPattern : @"^[a-zA-Z0-9]*$",
               FXModelValidatorMessage: @"es inválido",
               FXModelValidatorOn: @[@"login"]},
             
             @{FXModelValidatorAttributes : @[@"identification"],
               FXModelValidatorType : @"string",
               FXModelValidatorMin : @6,
               FXModelValidatorTooShort: @"debe tener al menos {min} dígitos",
               FXModelValidatorOn: @[@"login"]},
             
             @{FXModelValidatorAttributes : @[@"password"],
               FXModelValidatorType : @"match",
               FXModelValidatorPattern : @"^[0-9]*$",
               FXModelValidatorMessage: @"es inválida",
               FXModelValidatorOn: @[@"login"]},
             
             @{FXModelValidatorAttributes : @[@"password"],
               FXModelValidatorType : @"string",
               FXModelValidatorLength : @4,
               FXModelValidatorNotEqual: @"debe contener {length} dígitos",
               FXModelValidatorOn: @[@"login"]}];
    
}

@end