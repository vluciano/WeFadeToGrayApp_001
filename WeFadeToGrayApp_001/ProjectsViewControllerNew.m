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
#import "ContactViewController.h"
#import "DailiesOverviewViewController.h"
#import "DailyViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ProjectsViewControllerNew ()

@end


#define DEFAULT_ROW_HEIGHT 100
#define HEADER_HEIGHT 144


@implementation ProjectsViewControllerNew

@synthesize userName, userPassword, myTableView, headerView, footerView, sectionInfoArray, openSectionIndex,uniformRowHeight=rowHeight_, logoutBtn, loginUserName, actualProjectIdent;
@synthesize HUD, daily, currentPlaybackTime;

XMLProjectsParser *xmlProjectsParser;
XMLDailyParser *xmlDailyParser;

Boolean isProjectSelected = NO;



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
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"projectView_bg.png"]];
    self.headerView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"header_bg_pl.png"]];
    self.footerView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"footer_bg_pl.png"]];
    self.myTableView.backgroundColor = [UIColor clearColor];
    
    self.loginUserName.text = self.userName;
    
    xmlProjectsParser = [[XMLProjectsParser alloc] loadXMLByURL:@"http://dailies.wefadetogrey.de/api/get/projects.xml" AnduserName:userName AndPassword:userPassword];
    
    openSectionIndex = NSNotFound;
    
    [self.dailiesListBtn setSelected:YES];
    [self.overviewBtn setEnabled:NO];
    
    
    // Set up default values.
    self.myTableView.sectionHeaderHeight = HEADER_HEIGHT;
	/*
     The section info array is thrown away in viewWillUnload, so it's OK to set the default values here. If you keep the section information etc. then set the default values in the designated initializer.
     */
    rowHeight_ = DEFAULT_ROW_HEIGHT;
    
    self.myTableView.indicatorStyle=UIScrollViewIndicatorStyleWhite;

    [self.myTableView reloadData];
    
    self.currentPlaybackTime = 0.0f;
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
		
        sectionInfo.headerView = [[SectionHeaderView alloc] initWithFrame:CGRectMake(0.0, 0.0, 1024, HEADER_HEIGHT) AndProject:currentProject section:section delegate:self];
        
    }
    
    return sectionInfo.headerView; 
        
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return [[xmlProjectsParser projects] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    SectionInfo *sectionInfo = [self.sectionInfoArray objectAtIndex:section];
	NSInteger numDailiesInSection = [[sectionInfo.project dailies] count];
	
    return sectionInfo.open ? numDailiesInSection : 0;
    
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
    
    if (indexPath.row == 0) {
        [cell.selectedProjectView setHidden:NO];
    }else {
        [cell.selectedProjectView setHidden:YES];
    }
    
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return HEADER_HEIGHT;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath {
    
	SectionInfo *sectionInfo = [self.sectionInfoArray objectAtIndex:indexPath.section];
    
    CGFloat height = [[sectionInfo objectInRowHeightsAtIndex:indexPath.row] floatValue];
    
    return height;
    // Alternatively, return rowHeight.
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"-------> click row");
    
    
    Project *currentProject = [[xmlProjectsParser projects] objectAtIndex:indexPath.section];
    NSMutableArray *projectDailies = [currentProject dailies];
    DailySimple *dailySimple = [projectDailies objectAtIndex:indexPath.row];
    
    xmlDailyParser = [[XMLDailyParser alloc] loadXMLByURL:@"http://dailies.wefadetogrey.de/api/get/daily.xml" AndDailyIdent:dailySimple.ident AndUserName:userName AndPassword:userPassword];
    
    
    self.daily = xmlDailyParser.daily;
    
    
    [self performSegueWithIdentifier:@"fromProjectListToDailyView" sender:self];
        
    
}

#pragma mark Section header delegate

-(void)sectionHeaderView:(SectionHeaderView*)sectionHeaderView sectionOpened:(NSInteger)sectionOpened {
	
	SectionInfo *sectionInfo = [self.sectionInfoArray objectAtIndex:sectionOpened];
	
	sectionInfo.open = YES;
    
    /*
     Create an array containing the index paths of the rows to insert: These correspond to the rows for each quotation in the current section.
     */
    NSInteger countOfRowsToInsert = [sectionInfo.project.dailies count];
    NSMutableArray *indexPathsToInsert = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < countOfRowsToInsert; i++) {
        [indexPathsToInsert addObject:[NSIndexPath indexPathForRow:i inSection:sectionOpened]];
    }
    
    /*
     Create an array containing the index paths of the rows to delete: These correspond to the rows for each quotation in the previously-open section, if there was one.
     */
    NSMutableArray *indexPathsToDelete = [[NSMutableArray alloc] init];
    
    NSInteger previousOpenSectionIndex = self.openSectionIndex;
    if (previousOpenSectionIndex != NSNotFound) {
		
		SectionInfo *previousOpenSection = [self.sectionInfoArray objectAtIndex:previousOpenSectionIndex];
        previousOpenSection.open = NO;
        [previousOpenSection.headerView toggleOpenWithUserAction:NO];
        NSInteger countOfRowsToDelete = [previousOpenSection.project.dailies count];
        for (NSInteger i = 0; i < countOfRowsToDelete; i++) {
            [indexPathsToDelete addObject:[NSIndexPath indexPathForRow:i inSection:previousOpenSectionIndex]];
        }
    }
    
    // Style the animation so that there's a smooth flow in either direction.
    UITableViewRowAnimation insertAnimation;
    UITableViewRowAnimation deleteAnimation;
    if (previousOpenSectionIndex == NSNotFound || sectionOpened < previousOpenSectionIndex) {
        insertAnimation = UITableViewRowAnimationTop;
        deleteAnimation = UITableViewRowAnimationBottom;
    }
    else {
        insertAnimation = UITableViewRowAnimationBottom;
        deleteAnimation = UITableViewRowAnimationTop;
    }
    
    // Apply the updates.
    [self.myTableView beginUpdates];
    [self.myTableView insertRowsAtIndexPaths:indexPathsToInsert withRowAnimation:insertAnimation];
    [self.myTableView deleteRowsAtIndexPaths:indexPathsToDelete withRowAnimation:deleteAnimation];
    [self.myTableView endUpdates];
    
    self.openSectionIndex = sectionOpened;
    
    self.actualProjectIdent = sectionInfo.project.ident;
    
    [self.overviewBtn setEnabled:YES];
    
    [self.myTableView reloadData];
    
}


-(void)sectionHeaderView:(SectionHeaderView*)sectionHeaderView sectionClosed:(NSInteger)sectionClosed {
    
    /*
     Create an array of the index paths of the rows in the section that was closed, then delete those rows from the table view.
     */
	SectionInfo *sectionInfo = [self.sectionInfoArray objectAtIndex:sectionClosed];
	
    sectionInfo.open = NO;
    NSInteger countOfRowsToDelete = [self.myTableView numberOfRowsInSection:sectionClosed];
    
    if (countOfRowsToDelete > 0) {
        NSMutableArray *indexPathsToDelete = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < countOfRowsToDelete; i++) {
            [indexPathsToDelete addObject:[NSIndexPath indexPathForRow:i inSection:sectionClosed]];
        }
        [self.myTableView deleteRowsAtIndexPaths:indexPathsToDelete withRowAnimation:UITableViewRowAnimationTop];
    }
    self.openSectionIndex = NSNotFound;
    
    self.actualProjectIdent = nil;
    
    [self.overviewBtn setEnabled:NO];
    
    [self.myTableView reloadData];
}


- (IBAction)contactBtnClick:(id)sender {
    
    NSLog(@"contactBtnClick-----");
    [self performSegueWithIdentifier:@"fromProjectListToContact" sender:self];
}

- (IBAction)dailiesBtnClick:(id)sender {
    NSLog(@"dailiesBtnClick-----");
}

- (IBAction)overviewBtnClick:(id)sender {
    NSLog(@"overviewBtnClick-----");
    
    if (self.actualProjectIdent != nil) {
   
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDAnimationFade;
        hud.labelText = @"Loading";
        [hud setBackgroundColor:[UIColor colorWithRed:215.0/255.0 green:217.0/255.0 blue:223.0/255.0 alpha:0.6]];
        hud.dimBackground = YES;
        
        //[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            
            // Do task...
            [self performSegueWithIdentifier:@"fromProjectListToDailiesOverview" sender:self];
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
        
        //[self performSegueWithIdentifier:@"fromProjectListToDailiesOverview" sender:self];
    }
}

- (void)myTask {
	// Do something usefull in here instead of sleeping ...
	sleep(10);
}

#pragma mark -
#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)hud {
	// Remove HUD from screen when the HUD was hidded
	[self.HUD removeFromSuperview];
	self.HUD = nil;
}



- (IBAction)logoutBtnClick:(id)sender {
    
    NSLog(@"logoutBtnClick-----");
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userName"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userPassword"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"isLogin"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"switchValue"];
    
    [self performSegueWithIdentifier:@"fromProjectListToStart" sender:self];

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
        
    if([segue.identifier isEqualToString:@"fromProjectListToContact"]){
        
        ContactViewController *vc = [segue destinationViewController];
        vc.userName = self.userName;
    }
    if([segue.identifier isEqualToString:@"fromProjectListToDailiesOverview"]){
        
        DailiesOverviewViewController *vc = [segue destinationViewController];
        vc.userName = self.userName;
        vc.userPassword = self.userPassword;
        vc.projectIdent = self.actualProjectIdent;
    }
    
    if([segue.identifier isEqualToString:@"fromProjectListToDailyView"]){
        
        DailyViewController *vc = [segue destinationViewController];
        vc.userName = self.userName;
        vc.userPassword = self.userPassword;
        vc.projectIdent = self.actualProjectIdent;
        vc.dailyX = self.daily;
        
        vc.currentPlaybackTime = self.currentPlaybackTime;
    }
    
}


@end
