//
//  C4CStockForm.m
//  Agronegocios
//
//  Created by David Almeciga on 9/28/14.
//  Copyright (c) 2014 COOL4CODE. All rights reserved.
//

#import "C4CStockForm.h"

@implementation C4CStockForm

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

- (NSString *)productFieldDescription
{
    return self.product ? self.product.name : nil;
}

- (NSString *)unitFieldDescription
{
    return self.unit ? self.unit.name : nil;
}

- (NSArray *)fields
{
    return @[@{FXFormFieldKey: @"product",
               FXFormFieldTitle: @"Producto",
               FXFormFieldViewController: @"C4CProductTableViewController",
               @"textLabel.font": [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:18.0]},
             @{FXFormFieldKey: @"unit",
               FXFormFieldTitle: @"Unidad",
               FXFormFieldViewController: @"C4CUnitTableViewController",
               @"textLabel.font": [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:18.0]},
             @{FXFormFieldCell: [C4CNumericCell class],
               FXFormFieldKey: @"qty",
               FXFormFieldTitle: @"Cantidad",
               @"textLabel.font": [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:18.0]},
             @{FXFormFieldCell: [C4CNumericCell class],
               FXFormFieldKey: @"pricePerUnit",
               FXFormFieldTitle: @"Precio por unidad ($)",
               @"textLabel.font": [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:18.0]},
             @{FXFormFieldKey: @"expiresAt",
               FXFormFieldTitle: @"Fecha de vencimiento",
               @"textLabel.font": [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:18.0]}];
}

- (NSArray *)extraFields
{
    return @[@{FXFormFieldCell: [C4CBlueSubmitButtonCell class],
               FXFormFieldTitle: @"Guardar inventario",
               FXFormFieldHeader: @"",
               FXFormFieldAction: @"submitStockForm:"}];
}

-(NSArray *)rules {
    return @[@{FXModelValidatorAttributes : @[@"product", @"unit", @"qty", @"pricePerUnit", @"expiresAt"],
               FXModelValidatorType : @"required",
               FXModelValidatorMessage: @"es requerido",
               FXModelValidatorOn: @[@"createNewStock"]},
             
             @{FXModelValidatorAttributes : @[@"qty", @"pricePerUnit"],
               FXModelValidatorType : @"match",
               FXModelValidatorPattern : @"^[0-9]*$",
               FXModelValidatorMessage: @"es inválido",
               FXModelValidatorOn: @[@"createNewStock"]},
             
             @{FXModelValidatorAttributes : @[@"qty"],
               FXModelValidatorType : @"string",
               FXModelValidatorMax : @10,
               FXModelValidatorTooLong: @"no debe tener más de {max} dígitos",
               FXModelValidatorOn: @[@"createNewStock"]},
             
             @{FXModelValidatorAttributes : @[@"pricePerUnit"],
               FXModelValidatorType : @"string",
               FXModelValidatorMax : @15,
               FXModelValidatorTooLong: @"no debe tener más de {max} dígitos",
               FXModelValidatorOn: @[@"createNewStock"]}
             
             /*@{FXModelValidatorAttributes : @[@"expiresAt"],
              FXModelValidatorOn: @[@"createNewStock"]},*/];
    
}

@end
