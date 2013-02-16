//
//  DailyOverviewClipCell.h
//  WeFadeToGrayApp_001
//
//  Created by Vladimir Luciano on 2/15/13.
//  Copyright (c) 2013 Vladimir Luciano. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DailyOverviewClipCell : UICollectionViewCell

@property (strong, nonatomic, readonly) UIImageView *clipImageView;
@property (strong, nonatomic) UIImageView *sectionOverlayView;
@property (strong, nonatomic) UILabel *clipTitel;

- (void)setTitel:(NSString*)titel;

@end
