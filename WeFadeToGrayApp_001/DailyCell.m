//
//  ProjectCell.m
//  WeFadeToGrayApp_001
//
//  Created by Vladimir Luciano on 1/28/13.
//  Copyright (c) 2013 Vladimir Luciano. All rights reserved.
//

#import "DailyCell.h"

@implementation DailyCell

@synthesize dailyTitle, selectedProjectView;


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
