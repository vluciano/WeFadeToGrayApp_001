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

@synthesize sectionTitel, arrowView, sectionBgView;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.layer.borderColor = [UIColor clearColor].CGColor;
        self.layer.borderWidth = 0.0f;
        
        /*
         [self  setBackgroundColor:[UIColor colorWithRed:255 green:237 blue:0 alpha:1]];
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        self.layer.borderWidth = 0.5f;
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowRadius = 3.0f;
        self.layer.shadowOffset = CGSizeMake(0.0f, 2.0f);
        self.layer.shadowOpacity = 0.5f;
        */
         
         
        //Gradient Test
        /*
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 256, 100)];
        CAGradientLayer *gradient = [CAGradientLayer layer];
        gradient.frame = view.bounds;
        gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:255 green:237 blue:0 alpha:1] CGColor], (id)[[UIColor grayColor] CGColor], nil];
        [view.layer insertSublayer:gradient atIndex:0];
        [self addSubview:view];
         */
        
        
        
        self.sectionTitel = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 40.0f, 135.0f, 70.0f)];
        self.sectionTitel.backgroundColor = [UIColor clearColor];
        self.sectionTitel.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
        self.sectionTitel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
        [self.sectionTitel setTextColor:[UIColor grayColor]];
        
        
        //self.autoresizesSubviews = YES;
        //self.sectionTitel.textAlignment = NSTextAlignmentCenter;
        //self.clipTitel.adjustsFontSizeToFitWidth = YES;
        
        [self addSubview:self.sectionTitel];
        
        self.arrowView = [[UIImageView alloc] initWithFrame:CGRectMake(210.0f, 62.0f, 17.0f, 13.0f)];
        self.arrowView.image = [UIImage imageNamed:@"sequenz-pfeil.png"];
        [self addSubview:self.arrowView];
        
        
        /*
        UIView *bottomBorder = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 143.0f, self.frame.size.width, 1.0f)];
        bottomBorder.backgroundColor = [UIColor grayColor];
        [self addSubview:bottomBorder];
        */
        
        //Section Bg
        self.sectionBgView = [[UIImageView alloc] initWithFrame:self.bounds];
        self.sectionBgView.contentMode = UIViewContentModeScaleAspectFill;
        self.sectionBgView.clipsToBounds = YES;
        self.sectionBgView.image = [UIImage imageNamed:@"sequenz-bg.png"];
        
        [self.contentView addSubview:self.sectionBgView];
        
        
        
    }
    return self;
}

- (void)setTitel:(NSString*)titel {
    
    self.sectionTitel.text = titel;
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
