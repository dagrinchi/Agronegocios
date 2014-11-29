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

- (NSDictionary *)fullNameField
{
    return @{FXFormFieldHeader: @"Confirma tus datos",
             FXFormFieldKey: @"fullName",
             FXFormFieldTitle: @"Nombre completo",
             @"textLabel.font": [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:18.0]};
}

- (NSDictionary *)phoneField
{
    return @{FXFormFieldKey: @"phone",
             FXFormFieldTitle: @"No. móvil",
             @"textLabel.font": [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:18.0]};
}

- (NSDictionary *)qtyField
{
    return @{FXFormFieldKey: @"qty",
             FXFormFieldTitle: @"Cantidad",
             FXFormFieldType: @"unsigned",
             @"textLabel.font": [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:18.0]};
}

- (NSArray *) fields
{
    return @[@"fullName", @"phone", @"qty"];
}

- (NSArray *)extraFields
{
    return @[@{FXFormFieldCell: [C4CSubmitButtonCell class],
               FXFormFieldTitle: @"Enviar",
               FXFormFieldHeader: @"",
               FXFormFieldAction: @"submitOrderForm:"}];
}

-(NSArray *)rules {
    return @[@{FXModelValidatorAttributes : @[@"fullName", @"phone", @"qty"],
               FXModelValidatorType : @"required",
               FXModelValidatorOn: @[@"buy"]},
             
             @{FXModelValidatorAttributes : @[@"fullName"],
               FXModelValidatorType : @"string",
               FXModelValidatorMin : @8,
               FXModelValidatorOn: @[@"buy"]},
             
             @{FXModelValidatorAttributes : @[@"phone"],
               FXModelValidatorType : @"match",
               FXModelValidatorPattern : @"^[0-9]*$",
               FXModelValidatorOn: @[@"buy"]},
             
             @{FXModelValidatorAttributes : @[@"phone"],
               FXModelValidatorType : @"string",
               FXModelValidatorLength : @[@7, @10],
               FXModelValidatorOn: @[@"buy"]},
             
             @{FXModelValidatorAttributes : @[@"qty"],
               FXModelValidatorType : @"number",
               FXModelValidatorMin : @1,
               FXModelValidatorOn: @[@"buy"]},
             
             /*@{FXModelValidatorAttributes : @[@"expiresAt"],
              FXModelValidatorOn: @[@"createNewStock"]},*/];
    
}
@end
