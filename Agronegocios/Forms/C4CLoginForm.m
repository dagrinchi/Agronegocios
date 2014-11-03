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

- (NSArray *)fields {
    return @[@{FXFormFieldKey: @"identification",
               FXFormFieldType: FXFormFieldTypeNumber,
               FXFormFieldTitle: @"No. identificación",
               @"textLabel.font": [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:18.0]},
             @{FXFormFieldKey: @"password",
               FXFormFieldTitle: @"Clave",
               FXFormFieldType : FXFormFieldTypePassword,
               @"textLabel.font": [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:18.0]}];
}

- (NSArray *)extraFields
{
    return @[@{FXFormFieldCell: [C4CSubmitButtonCell class],
               FXFormFieldHeader: @"",
               FXFormFieldAction: @"submitLoginForm:"}];
}

@end