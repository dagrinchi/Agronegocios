//
//  C4CRegistrationForm.m
//  Agronegocios
//
//  Created by David Almeciga on 9/28/14.
//  Copyright (c) 2014 COOL4CODE. All rights reserved.
//

#import "C4CRegistrationForm.h"
#import "C4CSubmitButtonCell.h"

@implementation C4CRegistrationForm

- (NSArray *)fields {
    return @[@{FXFormFieldKey: @"identification",
               FXFormFieldTitle: @"Documento",
               FXFormFieldType: FXFormFieldTypeNumber,
               FXFormFieldHeader: @"Información de Acceso"},
             @{FXFormFieldKey: @"password",
               FXFormFieldTitle: @"Contraseña",},
             @{FXFormFieldKey: @"repeatPassword",
               FXFormFieldTitle: @"Confirmar Contraseña",},
             @{FXFormFieldKey: @"name",
               FXFormFieldHeader: @"Información Básica",
               FXFormFieldTitle: @"Nombre",
               @"textField.autocapitalizationType": @(UITextAutocapitalizationTypeWords)},
             @{FXFormFieldKey: @"email"},
             @{FXFormFieldKey: @"phone",
               FXFormFieldTitle: @"Teléfono móvil",},
             @{FXFormFieldKey: @"address",
               FXFormFieldTitle: @"Dirección",},
             @{//FXFormFieldCell: [C4CSubmitButtonCell class],
               FXFormFieldTitle: @"Enviar",
               FXFormFieldHeader: @"",
               FXFormFieldAction: @"submitRegistrationForm:"}];
}


@end
