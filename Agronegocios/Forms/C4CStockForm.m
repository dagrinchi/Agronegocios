//
//  C4CStockForm.m
//  Agronegocios
//
//  Created by David Almeciga on 9/28/14.
//  Copyright (c) 2014 COOL4CODE. All rights reserved.
//

#import "C4CStockForm.h"

@implementation C4CStockForm

- (NSArray *)products
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for (Product *product in _products) {
        [result addObject:product.name];
    }
    return result;
}

- (NSArray *)units
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for (Unit *unit in _units) {
        [result addObject:unit.name];
    }
    return result;
}

- (NSArray *)fields
{
    return @[@{FXFormFieldKey: @"product",
               FXFormFieldTitle: @"Producto",
               FXFormFieldOptions: self.products,
               FXFormFieldCell: [FXFormOptionPickerCell class],
               @"textLabel.font": [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:18.0]},
             @{FXFormFieldKey: @"unit",
               FXFormFieldTitle: @"Unidad",
               FXFormFieldOptions: self.units,
               FXFormFieldCell: [FXFormOptionPickerCell class],
               @"textLabel.font": [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:18.0]},
             @{FXFormFieldKey: @"qty",
               FXFormFieldTitle: @"Cantidad",
               @"textLabel.font": [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:18.0]},
             @{FXFormFieldKey: @"pricePerUnit",
               FXFormFieldTitle: @"Precio por unidad",
               @"textLabel.font": [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:18.0]},
             @{FXFormFieldKey: @"expiresAt",
               FXFormFieldTitle: @"Fecha de vencimiento",
               @"textLabel.font": [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:18.0]}];
}

- (NSArray *)extraFields
{
    return @[@{FXFormFieldCell: [C4CSubmitButtonCell class],
               FXFormFieldTitle: @"Enviar",
               FXFormFieldHeader: @"",
               FXFormFieldAction: @"submitStockForm:"}];
}


@end
