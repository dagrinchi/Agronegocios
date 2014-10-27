//
//  C4CLoginForm.m
//  Agronegocios
//
//  Created by David Almeciga on 9/28/14.
//  Copyright (c) 2014 COOL4CODE. All rights reserved.
//

#import "C4CLoginForm.h"
#import "C4CSubmitButtonCell.h"

@implementation C4CLoginForm

- (NSDictionary *)passwordField
{
    return @{FXFormFieldTitle: @"Clave", FXFormFieldType : FXFormFieldTypePassword};
}

- (NSArray *)fields {
    return @[@{FXFormFieldKey: @"identification",
               FXFormFieldType: FXFormFieldTypeNumber,
               FXFormFieldTitle: @"Documento"},
             @"password",
             @{FXFormFieldKey: @"rememberMe",
               FXFormFieldTitle: @"Recordarme"},
             @{FXFormFieldCell: [C4CSubmitButtonCell class],
               FXFormFieldTitle: @"Iniciar sesión",
               FXFormFieldAction: @"submitLoginForm:" }];
}

@end