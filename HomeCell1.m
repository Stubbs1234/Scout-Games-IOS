//
//  HomeCell1.m
//  Scout Games
//
//  Created by Alex Stubbs on 19/03/2015.
//  Copyright (c) 2015 Alex Stubbs. All rights reserved.
//

#import "HomeCell1.h"

@implementation HomeCell1

@synthesize cellTitle;

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
