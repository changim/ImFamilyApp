//
//  CJIMCustomTableViewCell.m
//  ImFamilyApp
//
//  Created by James Im on 12/17/12.
//  Copyright (c) 2012 James Im. All rights reserved.
//

#import "CJIMCustomTableViewCell.h"

@implementation CJIMCustomTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
