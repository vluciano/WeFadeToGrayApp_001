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

@property (nonatomic, strong, readwrite) UIImageView *imageView;

@end


@implementation DailyOverviewClipCell

@synthesize clipTitel, imageView;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor colorWithWhite:0.85f alpha:1.0f];
        
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        self.layer.borderWidth = 0.5f;
        //self.layer.shadowColor = [UIColor blackColor].CGColor;
        //self.layer.shadowRadius = 3.0f;
        //self.layer.shadowOffset = CGSizeMake(0.0f, 2.0f);
        //self.layer.shadowOpacity = 0.5f;
        
        self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.imageView.clipsToBounds = YES;
        
        [self.contentView addSubview:self.imageView];
        
        
        self.clipTitel = [[UILabel alloc] initWithFrame:self.bounds];
        self.clipTitel.backgroundColor = [UIColor clearColor];
        self.autoresizesSubviews = YES;
        self.clipTitel.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
        self.clipTitel.font = [UIFont boldSystemFontOfSize:12];
        self.clipTitel.textAlignment = NSTextAlignmentCenter;
        //self.clipTitel.adjustsFontSizeToFitWidth = YES;
        
        [self addSubview:self.clipTitel];

        
        
    }
    return self;
}

- (void)setTitel:(NSString*)titel {
    self.clipTitel.text = titel;
}


- (void)prepareForReuse {
    [super prepareForReuse];
    
    self.imageView.image = nil;
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
