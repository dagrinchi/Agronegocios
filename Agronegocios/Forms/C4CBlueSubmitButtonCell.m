//
//  C4CBlueSubmitButtonCell.m
//  Agronegocios
//
//  Created by David Almeciga on 11/5/14.
//  Copyright (c) 2014 COOL4CODE. All rights reserved.
//

#import "C4CBlueSubmitButtonCell.h"

@interface C4CBlueSubmitButtonCell ()

@property (strong, nonatomic) IBOutlet UIButton *cellButton;

@end

@implementation C4CBlueSubmitButtonCell

- (IBAction)submitAction:(id)sender {
    if (self.field.action) self.field.action(self);
}


@end
