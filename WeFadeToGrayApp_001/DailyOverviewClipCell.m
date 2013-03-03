//
//  DailyOverviewClipCell.m
//  WeFadeToGrayApp_001
//
//  Created by Vladimir Luciano on 2/15/13.
//  Copyright (c) 2013 Vladimir Luciano. All rights reserved.
//

#import "DailyOverviewClipCell.h"
#import <QuartzCore/QuartzCore.h>

@interface DailyOverviewClipCell ()

@property (nonatomic, strong, readwrite) UIImageView *clipImageView;

@end


@implementation DailyOverviewClipCell

@synthesize clipTitel, clipImageView, sectionOverlayView;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.layer.borderColor = [UIColor clearColor].CGColor;
        self.layer.borderWidth = 0.0f;

        /*
        self.backgroundColor = [UIColor colorWithWhite:0.85f alpha:1.0f];
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        self.layer.borderWidth = 0.5f;
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowRadius = 3.0f;
        self.layer.shadowOffset = CGSizeMake(0.0f, 2.0f);
        self.layer.shadowOpacity = 0.5f;
        */
         
        //Thumb
        self.clipImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        self.clipImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.clipImageView.clipsToBounds = YES;
        
        [self.contentView addSubview:self.clipImageView];
        
        //Clip Name
        //self.clipTitel = [[UILabel alloc] initWithFrame:self.bounds];
        self.clipTitel = [[UILabel alloc] initWithFrame:CGRectMake(3.0f, 3.0f, 100.0f, 20.0f)];
        self.clipTitel.backgroundColor = [UIColor clearColor];
        //self.clipTitel.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
        self.clipTitel.font = [UIFont boldSystemFontOfSize:10];
        //self.clipTitel.textAlignment = NSTextAlignmentCenter;
        [self.clipTitel setTextColor:[UIColor whiteColor]];
        
        //self.autoresizesSubviews = YES;
        
        [self addSubview:self.clipTitel];

        //Section Overlay
        self.sectionOverlayView = [[UIImageView alloc] initWithFrame:self.bounds];
        self.sectionOverlayView.contentMode = UIViewContentModeScaleAspectFill;
        self.sectionOverlayView.clipsToBounds = YES;
        
        [self.contentView addSubview:self.sectionOverlayView];
        
    }
    
    return self;
}

- (void)setTitel:(NSString*)titel {
    self.clipTitel.text = titel;
}


- (void)prepareForReuse {
    [super prepareForReuse];
    
    self.clipImageView.image = nil;
    self.sectionOverlayView.image = nil;
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
