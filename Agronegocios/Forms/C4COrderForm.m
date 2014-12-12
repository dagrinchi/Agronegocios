//
//  C4COrderForm.m
//  Agronegocios
//
//  Created by David Almeciga on 11/8/14.
//  Copyright (c) 2014 COOL4CODE. All rights reserved.
//

#import "C4COrderForm.h"

@implementation C4COrderForm

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

- (NSArray *) fields
{
    return @[@{FXFormFieldHeader: @"Confirma tus datos",
               FXFormFieldKey: @"fullName",
               FXFormFieldTitle: @"Nombre completo",
               @"textLabel.font": [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:18.0]},
             @{FXFormFieldKey: @"phone",
               FXFormFieldTitle: @"No. móvil",
               @"textLabel.font": [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:18.0]},
             @{FXFormFieldCell: [C4CNumericCell class],
               FXFormFieldKey: @"qty",
               FXFormFieldTitle: @"Cantidad",
               @"textLabel.font": [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:18.0]}];
}

- (NSArray *)extraFields
{
    return @[@{FXFormFieldCell: [C4CSubmitButtonCell class],
               FXFormFieldTitle: @"¡Confirmar compra!",
               FXFormFieldHeader: @"",
               FXFormFieldAction: @"submitOrderForm:"}];
}

-(NSArray *)rules {
    return @[@{FXModelValidatorAttributes : @[@"fullName", @"phone", @"qty"],
               FXModelValidatorType : @"required",
               FXModelValidatorMessage: @"es requerido",
               FXModelValidatorOn: @[@"buy"]},
             
             @{FXModelValidatorAttributes : @[@"fullName"],
               FXModelValidatorType : @"string",
               FXModelValidatorMin : @8,
               FXModelValidatorTooShort: @"debe tener al menos {min} caracteres",
               FXModelValidatorOn: @[@"buy"]},
             
             @{FXModelValidatorAttributes : @[@"phone"],
               FXModelValidatorType : @"match",
               FXModelValidatorPattern : @"^[0-9]*$",
               FXModelValidatorMessage: @"es inválido",
               FXModelValidatorOn: @[@"buy"]},
             
             @{FXModelValidatorAttributes : @[@"phone"],
               FXModelValidatorType : @"string",
               FXModelValidatorLength : @10,
               FXModelValidatorNotEqual: @"debe contener {length} dígitos",
               FXModelValidatorOn: @[@"buy"]},
             
             @{FXModelValidatorAttributes : @[@"qty"],
               FXModelValidatorType : @"match",
               FXModelValidatorPattern : @"^[0-9]*$",
               FXModelValidatorMessage: @"es inválido",
               FXModelValidatorOn: @[@"buy"]},
             
             @{FXModelValidatorAttributes : @[@"qty"],
               FXModelValidatorType : @"string",
               FXModelValidatorMax : @10,
               FXModelValidatorTooLong: @"no debe tener más de {max} dígitos",
               FXModelValidatorOn: @[@"buy"]}
             
             /*@{FXModelValidatorAttributes : @[@"expiresAt"],
              FXModelValidatorOn: @[@"createNewStock"]},*/];
    
}
@end
