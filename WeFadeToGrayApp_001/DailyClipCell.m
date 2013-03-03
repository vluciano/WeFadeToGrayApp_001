//
//  DailyClipCell.m
//  WeFadeToGrayApp_001
//
//  Created by Vladimir Luciano on 2/27/13.
//  Copyright (c) 2013 Vladimir Luciano. All rights reserved.
//

#import "DailyClipCell.h"
#import <QuartzCore/QuartzCore.h>


@interface DailyClipCell ()

@property (nonatomic, strong, readwrite) UIImageView *clipImageView;

@end

@implementation DailyClipCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.layer.borderColor = [UIColor grayColor].CGColor;
        self.layer.borderWidth = 0.5f;
        [self  setBackgroundColor:[UIColor colorWithRed:255 green:237 blue:0 alpha:1]];
        
    
        
        //Thumb
        self.clipImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 135.0f, 76.0f)];
        self.clipImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.clipImageView.clipsToBounds = YES;
        
        [self.contentView addSubview:self.clipImageView];
        
        //Clip Name
        self.clipTitel = [[UILabel alloc] initWithFrame:CGRectMake(3.0f, 83.0f, 120.0f, 20.0f)];
        self.clipTitel.backgroundColor = [UIColor clearColor];
        self.clipTitel.font = [UIFont systemFontOfSize:11];
        [self.clipTitel setTextColor:[UIColor blackColor]];
        
        [self addSubview:self.clipTitel];

    }
    return self;
}

- (void)setTitel:(NSString*)titel {
    self.clipTitel.text = titel;
}


- (void)prepareForReuse {
    [super prepareForReuse];
    
    self.clipImageView.image = nil;
    self.clipTitel.text = nil;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
