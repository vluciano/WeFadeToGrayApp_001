//
//  ProjectsViewControllerNew.m
//  WeFadeToGrayApp_001
//
//  Created by Vladimir Luciano on 1/29/13.
//  Copyright (c) 2013 Vladimir Luciano. All rights reserved.
//

#import "ProjectsViewControllerNew.h"

@interface ProjectsViewControllerNew ()

@end

@implementation ProjectsViewControllerNew

@synthesize userName, userPassword, myTableView, headerView, footerView;

XMLProjectsParser *xmlProjectsParser;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.headerView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"header_bg_pl.png"]];
    self.footerView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"footer_bg_pl.png"]];
    
    xmlProjectsParser = [[XMLProjectsParser alloc] loadXMLByURL:@"http://dailies.wefadetogrey.de/api/get/projects.xml" AnduserName:userName AndPassword:userPassword];
    
    [self.myTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    // create the parent view that will hold header Label
    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(10,0,300,60)];
    
    // create the label objects
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.font = [UIFont boldSystemFontOfSize:18];
    headerLabel.frame = CGRectMake(70,18,200,20);
    headerLabel.text =  @"Some Text";
    headerLabel.textColor = [UIColor redColor];
    
    UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    detailLabel.backgroundColor = [UIColor clearColor];
    detailLabel.textColor = [UIColor darkGrayColor];
    detailLabel.text = @"Some detail text";
    detailLabel.font = [UIFont systemFontOfSize:12];
    detailLabel.frame = CGRectMake(70,33,230,25);
        
    [customView addSubview:headerLabel];
    [customView addSubview:detailLabel];
    
    return customView;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return [[xmlProjectsParser projects] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    Project *currentProject = [[xmlProjectsParser projects] objectAtIndex:section];
    return [[currentProject dailies] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *CellIdentifier = @"ProjectCellNew";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[ProjectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    Project *currentProject = [[xmlProjectsParser projects] objectAtIndex:indexPath.section];
    
    NSMutableArray *projectDailies = [currentProject dailies];
    Daily *currentDaily = [projectDailies objectAtIndex:indexPath.row];
    
    
    
    cell.textLabel.text = currentDaily.name;
    
    /*
    UIColor *myColor = [UIColor colorWithRed:255.0/255.0 green:237.0/255.0 blue:0.0/255.0 alpha:1];
    
    cell.projectTitle.text = [currentProject name];
    cell.projectProduction.text = [currentProject production];
    cell.projectDoP.text = [currentProject dop];
    cell.projectRegie.text = [currentProject director];
    
    cell.projectTitle.textColor = myColor;
    cell.projectProduction.textColor = myColor;
    cell.projectDoP.textColor = myColor;
    cell.projectRegie.textColor = myColor;
    */
     
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"-------> click row");
    Project *currentProject = [[xmlProjectsParser projects] objectAtIndex:indexPath.row];
    NSMutableArray *currentDailies = [[NSMutableArray alloc] initWithArray:currentProject.dailies];
    NSLog(@"currentDailies --------------------");
    for (DailySimple *val in currentDailies) {
        NSLog(@"value Name is %@",val.name);
    }
    
}

@end
