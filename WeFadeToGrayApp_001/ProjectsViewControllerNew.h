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
@property (weak, nonatomic) IBOutlet UIButton *contactBtn;
@property (weak, nonatomic) IBOutlet UIButton *dailiesListBtn;
@property (weak, nonatomic) IBOutlet UIButton *overviewBtn;
@property (weak, nonatomic) IBOutlet UIButton *logoutBtn;
@property (weak, nonatomic) IBOutlet UILabel *loginUserName;


@property (nonatomic, strong) NSMutableArray* sectionInfoArray;
@property (nonatomic, assign) NSInteger openSectionIndex;

- (IBAction)contactBtnClick:(id)sender;
- (IBAction)dailiesBtnClick:(id)sender;
- (IBAction)overviewBtnClick:(id)sender;
- (IBAction)logoutBtnClick:(id)sender;

@property (nonatomic, assign) NSInteger uniformRowHeight;

@end
