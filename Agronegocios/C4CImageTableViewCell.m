//
//  C4CImageTableViewCell.m
//  Agronegocios
//
//  Created by David Almeciga on 7/8/14.
//  Copyright (c) 2014 COOL4CODE. All rights reserved.
//

#import "C4CImageTableViewCell.h"

@implementation C4CImageTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
