//
//  ProjectCell.h
//  WeFadeToGrayApp_001
//
//  Created by Vladimir Luciano on 1/28/13.
//  Copyright (c) 2013 Vladimir Luciano. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DailyCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *dailyTitle;
@property (weak, nonatomic) IBOutlet UIImageView *selectedProjectView;
@property (strong, nonatomic) IBOutlet UIImageView *dailyCell_bg;

@end
