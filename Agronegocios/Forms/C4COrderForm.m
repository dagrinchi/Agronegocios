//
//  C4COrderForm.m
//  Agronegocios
//
//  Created by David Almeciga on 11/8/14.
//  Copyright (c) 2014 COOL4CODE. All rights reserved.
//

#import "C4COrderForm.h"

@implementation C4COrderForm

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

@end
