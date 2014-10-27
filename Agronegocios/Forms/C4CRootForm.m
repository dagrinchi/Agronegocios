//
//  C4CRootForm.m
//  Agronegocios
//
//  Created by David Almeciga on 9/28/14.
//  Copyright (c) 2014 COOL4CODE. All rights reserved.
//

#import "C4CRootForm.h"

@implementation C4CRootForm

- (NSDictionary *)loginField {
    return @{ FXFormFieldHeader: @"Iniciar sesión",
              FXFormFieldInline: @YES };
}

- (NSDictionary *)registrationField {
    return @{ FXFormFieldHeader: @"¿No tienes cuenta?",
              FXFormFieldTitle: @"Regístrate" };
}

@end