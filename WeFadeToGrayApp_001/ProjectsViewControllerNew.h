//
//  ProjectsViewControllerNew.h
//  WeFadeToGrayApp_001
//
//  Created by Vladimir Luciano on 1/27/13.
//  Copyright (c) 2013 Vladimir Luciano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMLProjectsParser.h"
#import "XMLDailiesParser.h"
#import "Project.h"
#import "DailySimple.h"

@interface ProjectsViewControllerNew : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) NSString *userName;
@property (weak, nonatomic) NSString *userPassword;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIView *footerView;

@end
