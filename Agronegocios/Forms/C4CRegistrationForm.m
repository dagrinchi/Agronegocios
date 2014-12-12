//
//  C4CRegistrationForm.m
//  Agronegocios
//
//  Created by David Almeciga on 9/28/14.
//  Copyright (c) 2014 COOL4CODE. All rights reserved.
//

#import "C4CRegistrationForm.h"

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
             @{FXFormFieldCell: [C4CPasswordCell class],
               FXFormFieldKey: @"password",
               @"textLabel.font": [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:18.0],
               FXFormFieldTitle: @"Clave",
               @"textLabel.font": [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:18.0],
               FXFormFieldHeader: @"Usa 4 dígitos como clave"},
             @{FXFormFieldCell: [C4CPasswordCell class],
               FXFormFieldKey: @"repeatPassword",
               @"textLabel.font": [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:18.0],
               FXFormFieldTitle: @"Re-clave"}];
}

- (NSArray *)extraFields
{
    return @[@{FXFormFieldTitle: @"Registrarme",
               FXFormFieldHeader: @"",
               FXFormFieldCell: [C4CGreenSubmitButtonCell class],
               FXFormFieldAction: @"submitRegistrationForm:"}];
}

-(NSArray *)rules {
    return @[@{FXModelValidatorAttributes : @[@"name", @"identification", @"phone", @"email", @"address", @"password", @"repeatPassword"],
               FXModelValidatorType : @"required",
               FXModelValidatorMessage: @"es requerido",
               FXModelValidatorOn: @[@"register"]},
             
             @{FXModelValidatorAttributes : @[@"name", @"address"],
               FXModelValidatorType : @"string",
               FXModelValidatorMin : @8,
               FXModelValidatorTooShort: @"debe tener al menos {min} carateres",
               FXModelValidatorOn: @[@"register"]},
             
             @{FXModelValidatorAttributes : @[@"identification"],
               FXModelValidatorType : @"match",
               FXModelValidatorPattern : @"^[a-zA-Z0-9]*$",
               FXModelValidatorMessage: @"es inválido",
               FXModelValidatorOn: @[@"register"]},
             
             @{FXModelValidatorAttributes : @[@"identification"],
               FXModelValidatorType : @"string",
               FXModelValidatorMin : @6,
               FXModelValidatorTooShort: @"debe tener al menos {min} dígitos",
               FXModelValidatorOn: @[@"register"]},
             
             @{FXModelValidatorAttributes : @[@"phone"],
               FXModelValidatorType : @"match",
               FXModelValidatorPattern : @"^[0-9]*$",
               FXModelValidatorMessage: @"es inválido",
               FXModelValidatorOn: @[@"register"]},
             
             @{FXModelValidatorAttributes : @[@"phone"],
               FXModelValidatorType : @"string",
               FXModelValidatorLength : @10,
               FXModelValidatorNotEqual: @"debe tener {length} dígitos",
               FXModelValidatorOn: @[@"register"]},
             
             @{FXModelValidatorAttributes : @[@"email"],
               FXModelValidatorType : @"email",
               FXModelValidatorMessage: @"es inválido",
               FXModelValidatorOn: @[@"register"]},
             
             @{FXModelValidatorAttributes : @[@"password"],
               FXModelValidatorType : @"match",
               FXModelValidatorPattern : @"^[0-9]*$",
               FXModelValidatorMessage: @"es inválido",
               FXModelValidatorOn: @[@"register"]},
             
             @{FXModelValidatorAttributes : @[@"password"],
               FXModelValidatorType : @"string",
               FXModelValidatorLength : @4,
               FXModelValidatorNotEqual: @"debe tener {length} dígitos",
               FXModelValidatorOn: @[@"register"]},
             
             @{FXModelValidatorAttributes : @[@"repeatPassword"],
               FXModelValidatorType : @"compare",
               FXModelValidatorCompareAttribute : @"password",
               FXModelValidatorMessage: @"debe ser igual a la Clave",
               FXModelValidatorOn: @[@"register"]}];
    
}


@end
