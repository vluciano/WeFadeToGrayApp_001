//
//  DailyOverviewCell.h
//  WeFadeToGrayApp_001
//
//  Created by Vladimir Luciano on 2/15/13.
//  Copyright (c) 2013 Vladimir Luciano. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DailyOverviewSectionCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *clipTitel;

- (void)setSectionTitel:(NSString*)titel;

@end
