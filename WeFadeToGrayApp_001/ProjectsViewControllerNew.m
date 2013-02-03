//
//  ProjectsViewControllerNew.m
//  WeFadeToGrayApp_001
//
//  Created by Vladimir Luciano on 1/29/13.
//  Copyright (c) 2013 Vladimir Luciano. All rights reserved.
//

#import "ProjectsViewControllerNew.h"
#import "SectionHeaderView.h"
#import "SectionInfo.h"

@interface ProjectsViewControllerNew ()

@end


#define DEFAULT_ROW_HEIGHT 100
#define HEADER_HEIGHT 149


@implementation ProjectsViewControllerNew

@synthesize userName, userPassword, myTableView, headerView, footerView, sectionInfoArray, openSectionIndex;

XMLProjectsParser *xmlProjectsParser;



-(BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)viewWillAppear:(BOOL)animated {
	
	[super viewWillAppear:animated];
	
    if ((self.sectionInfoArray == nil) || ([self.sectionInfoArray count] != [self numberOfSectionsInTableView:self.myTableView])) {
		
        // For each play, set up a corresponding SectionInfo object to contain the default height for each row.
		NSMutableArray *infoArray = [[NSMutableArray alloc] init];
		
		for (Project *project in [xmlProjectsParser projects]) {
			
			SectionInfo *sectionInfo = [[SectionInfo alloc] init];
			sectionInfo.project = project;
			sectionInfo.open = NO;
			
            NSNumber *defaultRowHeight = [NSNumber numberWithInteger:DEFAULT_ROW_HEIGHT];
			NSInteger countOfDailies = [[sectionInfo.project dailies] count];
			for (NSInteger i = 0; i < countOfDailies; i++) {
				[sectionInfo insertObject:defaultRowHeight inRowHeightsAtIndex:i];
			}
			
			[infoArray addObject:sectionInfo];
		}
		
		self.sectionInfoArray = infoArray;
	}
	
}





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
    
    openSectionIndex = NSNotFound;

    
    [self.myTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    
    /*
     Create the section header views lazily.
     */
    
    Project *currentProject = [[xmlProjectsParser projects] objectAtIndex:section];

    
	SectionInfo *sectionInfo = [self.sectionInfoArray objectAtIndex:section];
    
    if (!sectionInfo.headerView) {
		
        sectionInfo.headerView = [[SectionHeaderView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.myTableView.bounds.size.width, HEADER_HEIGHT) AndProject:currentProject section:section delegate:self];
        
    }
    
    return sectionInfo.headerView; 
        
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
