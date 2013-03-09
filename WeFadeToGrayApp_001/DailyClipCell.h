//
//  DailyClipCell.h
//  WeFadeToGrayApp_001
//
//  Created by Vladimir Luciano on 2/27/13.
//  Copyright (c) 2013 Vladimir Luciano. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DailyClipCell : UICollectionViewCell

@property (strong, nonatomic, readonly) UIImageView *clipImageView;
@property (strong, nonatomic) UILabel *clipTitel;
@property (strong, nonatomic) UIActivityIndicatorView *ai;

- (void)setTitel:(NSString*)titel;

@end
