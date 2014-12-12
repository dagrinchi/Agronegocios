//
//  C4CSubmitButtonCell.m
//  Agronegocios
//
//  Created by David Almeciga on 9/28/14.
//  Copyright (c) 2014 COOL4CODE. All rights reserved.
//

#import "C4CSubmitButtonCell.h"

@interface C4CSubmitButtonCell ()

@property (nonatomic, strong) IBOutlet UIButton *cellButton;

@end

@implementation C4CSubmitButtonCell

- (void)update
{
    [self.cellButton setTitle:self.field.title forState:UIControlStateNormal];
}

- (IBAction)submitAction:(id)sender {
    if (self.field.action) self.field.action(self);
}


@end
