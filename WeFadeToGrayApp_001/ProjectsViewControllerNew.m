//
//  ProjectsViewControllerNew.m
//  WeFadeToGrayApp_001
//
//  Created by Vladimir Luciano on 1/27/13.
//  Copyright (c) 2013 Vladimir Luciano. All rights reserved.
//

#import "ProjectsViewControllerNew.h"

@interface ProjectsViewControllerNew ()

@end

@implementation ProjectsViewControllerNew

@synthesize userName, userPassword, myTableView;

XMLProjectsParser *xmlProjectsParser;
XMLDailiesParser *xmlDailiesParser;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    xmlProjectsParser = [[XMLProjectsParser alloc] loadXMLByURL:@"http://dailies.wefadetogrey.de/api/get/projects.xml" AnduserName:userName AndPassword:userPassword];
    
    [self.myTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [[xmlProjectsParser projects] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"ProjectCell";
    Project *currentProject = [[xmlProjectsParser projects] objectAtIndex:indexPath.row];
    
    NSMutableArray *currentDailies = [[NSMutableArray alloc] initWithArray:currentProject.dailies];
    
    NSLog(@"currentDailies --------------------");
    for (DailySimple *val in currentDailies) {
        NSLog(@"value Name is %@",val.name);
    }
    
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSString *rowText = [NSString stringWithFormat:@"%@ - %@ - %@", [currentProject name], [currentProject production], [currentProject dop]];
    
    cell.textLabel.text = rowText;
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"-------> click row");
    
}

@end
