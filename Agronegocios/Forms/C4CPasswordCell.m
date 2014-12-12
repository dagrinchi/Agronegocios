//
//  C4CPasswordCell.m
//  Agronegocios
//
//  Created by David Almeciga on 12/12/14.
//  Copyright (c) 2014 COOL4CODE. All rights reserved.
//

#import "C4CPasswordCell.h"

@implementation C4CPasswordCell

- (void)update
{
    [super update];
    self.textField.keyboardType = UIKeyboardTypeNumberPad;
}

@end
