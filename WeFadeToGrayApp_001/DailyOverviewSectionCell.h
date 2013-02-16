//
//  DailyOverviewCell.h
//  WeFadeToGrayApp_001
//
//  Created by Vladimir Luciano on 2/15/13.
//  Copyright (c) 2013 Vladimir Luciano. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DailyOverviewSectionCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *sectionTitel;
@property (nonatomic, strong) UIImageView *arrowView;
@property (strong, nonatomic) UIImageView *sectionBgView;



- (void)setTitel:(NSString*)titel;

@end
