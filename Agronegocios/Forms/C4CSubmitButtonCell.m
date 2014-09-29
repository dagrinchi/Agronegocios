//
//  C4CSubmitButtonCell.m
//  Agronegocios
//
//  Created by David Almeciga on 9/28/14.
//  Copyright (c) 2014 COOL4CODE. All rights reserved.
//

#import "C4CSubmitButtonCell.h"

@interface C4CSubmitButtonCell ()

@property (weak, nonatomic) IBOutlet UIButton *cellButton;

@end

@implementation C4CSubmitButtonCell

- (IBAction)submitAction:(id)sender {
    if (self.field.action) self.field.action(self);
}


@end
