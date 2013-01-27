//
//  ProjectsViewController.h
//  WeFadeToGrayApp_001
//
//  Created by Vladimir Luciano on 1/26/13.
//  Copyright (c) 2013 Vladimir Luciano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMLProjectsParser.h"
#import "XMLDailiesParser.h"
#import "Project.h"
#import "DailySimple.h"


@interface ProjectsViewController : UITableViewController

@property (weak, nonatomic) NSString *userName;
@property (weak, nonatomic) NSString *userPassword;

@end
