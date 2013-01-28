//
//  ProjectCell.h
//  WeFadeToGrayApp_001
//
//  Created by Vladimir Luciano on 1/28/13.
//  Copyright (c) 2013 Vladimir Luciano. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProjectCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *projectTitle;
@property (weak, nonatomic) IBOutlet UILabel *projectProduction;
@property (weak, nonatomic) IBOutlet UILabel *projectDoP;
@property (weak, nonatomic) IBOutlet UILabel *projectRegie;

@end
