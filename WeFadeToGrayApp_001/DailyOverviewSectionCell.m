//
//  DailyOverviewCell.m
//  WeFadeToGrayApp_001
//
//  Created by Vladimir Luciano on 2/15/13.
//  Copyright (c) 2013 Vladimir Luciano. All rights reserved.
//

#import "DailyOverviewSectionCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation DailyOverviewSectionCell

@synthesize clipTitel;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self  setBackgroundColor:[UIColor colorWithRed:255 green:237 blue:0 alpha:1]];
        
        
        //Gradient Test
        /*
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 256, 100)];
        CAGradientLayer *gradient = [CAGradientLayer layer];
        gradient.frame = view.bounds;
        gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:255 green:237 blue:0 alpha:1] CGColor], (id)[[UIColor grayColor] CGColor], nil];
        [view.layer insertSublayer:gradient atIndex:0];
        [self addSubview:view];
         */
        
        
        
        self.clipTitel = [[UILabel alloc] initWithFrame:self.bounds];
        self.clipTitel.backgroundColor = [UIColor clearColor];
        self.autoresizesSubviews = YES;
        self.clipTitel.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
        self.clipTitel.font = [UIFont boldSystemFontOfSize:18];
        self.clipTitel.textAlignment = NSTextAlignmentCenter;
        //self.clipTitel.adjustsFontSizeToFitWidth = YES;
        
        [self addSubview:self.clipTitel];
        
        
        UIView *bottomBorder = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 143.0f, self.frame.size.width, 1.0f)];
        bottomBorder.backgroundColor = [UIColor grayColor];
        [self addSubview:bottomBorder];
        
        
    }
    return self;
}

- (void)setSectionTitel:(NSString*)titel {
    
    self.clipTitel.text = titel;
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
