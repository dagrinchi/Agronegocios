//
//  C4CGreenSubmitButtonCell.m
//  Agronegocios
//
//  Created by David Almeciga on 11/9/14.
//  Copyright (c) 2014 COOL4CODE. All rights reserved.
//

#import "C4CGreenSubmitButtonCell.h"

@implementation C4CGreenSubmitButtonCell

- (void)update
{
    [self.cellButton setTitle:self.field.title forState:UIControlStateNormal];
}

- (IBAction)submitAction:(id)sender {
    if (self.field.action) self.field.action(self);
}

@end
