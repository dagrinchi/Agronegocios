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

- (NSDictionary *)productField
{
    return @{FXFormFieldKey: @"product",
             FXFormFieldTitle: @"Producto",
             FXFormFieldViewController: @"C4CProductTableViewController",
             @"textLabel.font": [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:18.0]};
}

- (NSString *)productFieldDescription
{
    return self.product ? self.product.name : nil;
}

- (NSDictionary *)unitField
{
    return @{FXFormFieldKey: @"unit",
             FXFormFieldTitle: @"Unidad",
             FXFormFieldViewController: @"C4CUnitTableViewController",
             @"textLabel.font": [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:18.0]};
}

- (NSString *)unitFieldDescription
{
    return self.unit ? self.unit.name : nil;
}

- (NSDictionary *)qtyField
{
    return @{FXFormFieldKey: @"qty",
             FXFormFieldTitle: @"Cantidad",
             FXFormFieldType: @"unsigned",
             @"textLabel.font": [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:18.0]};
}

- (NSDictionary *)pricePerUnitField
{
    return @{FXFormFieldKey: @"pricePerUnit",
             FXFormFieldTitle: @"Precio por unidad ($)",
             FXFormFieldType: @"unsigned",
             @"textLabel.font": [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:18.0]};
}

- (NSArray *)fields
{
    return @[@"product",
             @"unit",
             @"qty",
             @"pricePerUnit",
             @{FXFormFieldKey: @"expiresAt",
               FXFormFieldTitle: @"Fecha de vencimiento",
               @"textLabel.font": [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:18.0]}];
}

- (NSArray *)extraFields
{
    return @[@{FXFormFieldCell: [C4CBlueSubmitButtonCell class],
               FXFormFieldTitle: @"Enviar",
               FXFormFieldHeader: @"",
               FXFormFieldAction: @"submitStockForm:"}];
}

-(NSArray *)rules {
    return @[@{FXModelValidatorAttributes : @[@"product", @"unit", @"qty", @"pricePerUnit", @"expiresAt"],
               FXModelValidatorType : @"required",
               FXModelValidatorOn: @[@"createNewStock"]},
             
             @{FXModelValidatorAttributes : @[@"qty"],
               FXModelValidatorType : @"number",
               FXModelValidatorMin : @1,
               FXModelValidatorOn: @[@"createNewStock"]},
             
             @{FXModelValidatorAttributes : @[@"pricePerUnit"],
               FXModelValidatorType : @"number",
               FXModelValidatorMin : @1,
               FXModelValidatorOn: @[@"createNewStock"]},
             
             /*@{FXModelValidatorAttributes : @[@"expiresAt"],
               FXModelValidatorOn: @[@"createNewStock"]},*/];
    
}

@end
