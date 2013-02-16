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

@synthesize sectionTitel, arrowView;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self  setBackgroundColor:[UIColor colorWithRed:255 green:237 blue:0 alpha:1]];
        
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        self.layer.borderWidth = 0.5f;

        
        
        /*
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        self.layer.borderWidth = 3.0f;
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
        
        
        
        self.sectionTitel = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 40.0f, 200.0f, 60.0f)];
        self.sectionTitel.backgroundColor = [UIColor clearColor];
        self.sectionTitel.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
        self.sectionTitel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
        [self.sectionTitel setTextColor:[UIColor grayColor]];
        
        //self.autoresizesSubviews = YES;
        //self.sectionTitel.textAlignment = NSTextAlignmentCenter;
        //self.clipTitel.adjustsFontSizeToFitWidth = YES;
        
        [self addSubview:self.sectionTitel];
        
        self.arrowView = [[UIImageView alloc] initWithFrame:CGRectMake(230.0f, 63.0f, 17.0f, 13.0f)];
        self.arrowView.image = [UIImage imageNamed:@"sequenz-pfeil.png"];
        [self addSubview:self.arrowView];
        
        
        /*
        UIView *bottomBorder = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 143.0f, self.frame.size.width, 1.0f)];
        bottomBorder.backgroundColor = [UIColor grayColor];
        [self addSubview:bottomBorder];
        */
        
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
