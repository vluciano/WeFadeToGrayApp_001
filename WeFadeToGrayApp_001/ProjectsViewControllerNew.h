//
//  ProjectsViewControllerNew.h
//  WeFadeToGrayApp_001
//
//  Created by Vladimir Luciano on 1/29/13.
//  Copyright (c) 2013 Vladimir Luciano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMLProjectsParser.h"
#import "XMLDailiesParser.h"
#import "Project.h"
#import "DailySimple.h"
#import "DailyCell.h"
#import "SectionHeaderView.h"

@interface ProjectsViewControllerNew : UIViewController <SectionHeaderViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) NSString *userName;
@property (weak, nonatomic) NSString *userPassword;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIView *footerView;

@property (nonatomic, strong) NSMutableArray* sectionInfoArray;
@property (nonatomic, assign) NSInteger openSectionIndex;

@property (nonatomic, assign) NSInteger uniformRowHeight;

@end
