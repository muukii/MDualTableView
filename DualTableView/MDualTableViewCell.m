//
//  MDualTableViewCell.m
//  DualTableView
//
//  Created by Muukii on 10/24/13.
//  Copyright (c) 2013 Muukii. All rights reserved.
//

#import "MDualTableViewCell.h"

@implementation MDualTableViewCell

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
