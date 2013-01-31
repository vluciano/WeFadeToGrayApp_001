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
    
    Project *currentProject = [[xmlProjectsParser projects] objectAtIndex:section];
    
    // create the parent view that will hold header Label
    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(0,0,1024,149)];
    [customView setBackgroundColor:[UIColor blackColor]];
    
    UIColor *myColor = [UIColor colorWithRed:255.0/255.0 green:237.0/255.0 blue:0.0/255.0 alpha:1];
    
    // create the label objects
    UILabel *titelText = [[UILabel alloc] initWithFrame:CGRectZero];
    titelText.backgroundColor = [UIColor clearColor];
    titelText.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    titelText.frame = CGRectMake(30,30,600,20);
    titelText.text =  currentProject.name;
    titelText.textColor = myColor;
    
    //---------------------------------------//
    UILabel *productionLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    productionLabel.backgroundColor = [UIColor clearColor];
    productionLabel.textColor = [UIColor whiteColor];
    productionLabel.text = @"Production";
    productionLabel.font = [UIFont fontWithName:@"Helvetica" size:10];
    productionLabel.frame = CGRectMake(30,70,150,20);
    
    UILabel *productionText = [[UILabel alloc] initWithFrame:CGRectZero];
    productionText.backgroundColor = [UIColor clearColor];
    productionText.font = [UIFont fontWithName:@"Helvetica" size:13];
    productionText.frame = CGRectMake(30,90,200,20);
    productionText.text =  currentProject.production;
    productionText.textColor = myColor;

    //---------------------------------------//
    
    
    UILabel *directorLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    directorLabel.backgroundColor = [UIColor clearColor];
    directorLabel.textColor = [UIColor whiteColor];
    directorLabel.text = @"Director";
    directorLabel.font = [UIFont fontWithName:@"Helvetica" size:10];
    directorLabel.frame = CGRectMake(300,70,150,20);
    
    UILabel *directorText = [[UILabel alloc] initWithFrame:CGRectZero];
    directorText.backgroundColor = [UIColor clearColor];
    directorText.font = [UIFont fontWithName:@"Helvetica" size:13];
    directorText.frame = CGRectMake(300,90,200,20);
    directorText.text =  currentProject.director;
    directorText.textColor = myColor;

    
    //---------------------------------------//
    
    
    UILabel *dopLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    dopLabel.backgroundColor = [UIColor clearColor];
    dopLabel.textColor = [UIColor whiteColor];
    dopLabel.text = @"DoP";
    dopLabel.font = [UIFont fontWithName:@"Helvetica" size:10];
    dopLabel.frame = CGRectMake(600,70,150,20);
    
    UILabel *dopText = [[UILabel alloc] initWithFrame:CGRectZero];
    dopText.backgroundColor = [UIColor clearColor];
    dopText.font = [UIFont fontWithName:@"Helvetica" size:13];
    dopText.frame = CGRectMake(600,90,200,20);
    dopText.text =  currentProject.dop;
    dopText.textColor = myColor;

    //---------------------------------------//
    
    
    [customView addSubview:titelText];
    
    [customView addSubview:productionLabel];
    [customView addSubview:productionText];
    
    [customView addSubview:directorLabel];
    [customView addSubview:directorText];
    
    [customView addSubview:dopLabel];
    [customView addSubview:dopText];
    
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
    
    DailyCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[DailyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    Project *currentProject = [[xmlProjectsParser projects] objectAtIndex:indexPath.section];
    
    NSMutableArray *projectDailies = [currentProject dailies];
    Daily *currentDaily = [projectDailies objectAtIndex:indexPath.row];
    
    cell.dailyTitle.text = currentDaily.name;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 149.0;
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
