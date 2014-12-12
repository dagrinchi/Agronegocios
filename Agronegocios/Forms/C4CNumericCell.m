//
//  C4CNumericCell.m
//  Agronegocios
//
//  Created by David Almeciga on 12/12/14.
//  Copyright (c) 2014 COOL4CODE. All rights reserved.
//

#import "C4CNumericCell.h"

@implementation C4CNumericCell

-(void) update
{
    [super update];
    self.textField.keyboardType = UIKeyboardTypeNumberPad;
}

@end
