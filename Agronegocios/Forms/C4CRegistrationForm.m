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

- (NSArray *)fields {
    return @[@{FXFormFieldKey: @"name",
               FXFormFieldHeader: @"Información Básica",
               FXFormFieldTitle: @"Nombre completo",
               @"textLabel.font": [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:18.0],
               @"textField.autocapitalizationType": @(UITextAutocapitalizationTypeWords)},
             @{FXFormFieldKey: @"identification",
               FXFormFieldTitle: @"No. identificación",
               @"textLabel.font": [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:18.0],
               FXFormFieldType: FXFormFieldTypeNumber},
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


@end
