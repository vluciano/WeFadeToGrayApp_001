//
//  DailieOverviewViewController.m
//  WeFadeToGrayApp_001
//
//  Created by Vladimir Luciano on 2/11/13.
//  Copyright (c) 2013 Vladimir Luciano. All rights reserved.
//

#import "DailiesOverviewViewController.h"
#import "ContactViewController.h"
#import "XMLDailiesParser.h"
#import "DailyOverviewSectionCell.h"
#import "DailyOverviewClipCell.h"
#import "ProjectsViewControllerNew.h"
#import "DailyViewController.h"
#import "Reachability.h"
#import <SystemConfiguration/SystemConfiguration.h>

@interface DailiesOverviewViewController ()
@end



@implementation DailiesOverviewViewController

@synthesize userNameDO, userPasswordDO, headerView, footerView, logoutBtn, loginUserName, projectIdent, myCollectionView, thumbnailQueue, currentPlaybackTimeDO, openSectionIndexDO;

XMLDailiesParser *xmlDailiesParser;
XMLDailyParser *xmlDailyParser;

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
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"dailiesOverviewView_bg.png"]];
    self.headerView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"header_bg_pl.png"]];
    self.footerView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"footer_bg_pl.png"]];
    
    self.loginUserName.text = self.userNameDO;
    [self.overviewBtn setSelected:YES];
    
    if(xmlDailiesParser == nil){
        
         xmlDailiesParser = [[XMLDailiesParser alloc] loadXMLByURL:@"http://dailies.wefadetogrey.de/api/get/dailies.xml" AndProjectIdent:projectIdent AndUserName:userNameDO AndPassword:userPasswordDO];
    }
        
    
    /*
    for (Daily *daily in [xmlDailiesParser dailies]) {
        for (Clip *clip in daily.clips) {
            NSLog(@"clipName: %@", clip.clipName);
        }
    }
    */
    
    
    //UICollection
    self.myCollectionView.backgroundColor = [UIColor clearColor];
    [self.myCollectionView registerClass:[DailyOverviewSectionCell class] forCellWithReuseIdentifier:@"SectionCell"];
    [self.myCollectionView registerClass:[DailyOverviewClipCell class] forCellWithReuseIdentifier:@"ClipCell"];
    self.myCollectionView.pagingEnabled = NO;
    
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout*)self.myCollectionView.collectionViewLayout;
    //flowLayout.sectionInset = UIEdgeInsetsMake(20, 0, 20, 0);
    flowLayout.itemSize = CGSizeMake(256, 144);
    [flowLayout setMinimumInteritemSpacing:0.f];
    [flowLayout setMinimumLineSpacing:0.f];
    
    
    self.thumbnailQueue = [[NSOperationQueue alloc] init];
    self.thumbnailQueue.maxConcurrentOperationCount = NSOperationQueueDefaultMaxConcurrentOperationCount;
    
    [self.myCollectionView reloadData];
    
    self.currentPlaybackTimeDO = 0.0f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    Daily *dailySection = [[xmlDailiesParser dailies] objectAtIndex:section];
    NSInteger numClipsInDaily = [[dailySection clips] count];
    return (numClipsInDaily > 0) ? numClipsInDaily : numClipsInDaily + 1;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    //check if sectionStart
    Daily *currentDaily = [[xmlDailiesParser dailies] objectAtIndex:indexPath.section];
    NSMutableArray *dailyClips = [currentDaily clips];
    Clip *currentClip = [dailyClips objectAtIndex:indexPath.row];
    
    //NSLog(@"-----------");
    //NSLog(@"idexPath.Section --->%i", indexPath.section);
    //NSLog(@"idexPath.row --->%i", indexPath.row);
    
    
    static NSString *identifier;
    if (indexPath.row == 0) {
        
        identifier = @"SectionCell";
        DailyOverviewSectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        
        cell.sectionTitel.numberOfLines = 2;
        
        [cell setTitel:currentDaily.name];
        return cell;
        
    }else {
        identifier = @"ClipCell";
        
        DailyOverviewClipCell *cell1 = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        //cell1.clipTitel.text = currentClip.clipName;
        
        if (indexPath.row == 1) {
            cell1.sectionOverlayView.image = [UIImage imageNamed:@"sequenz-verlauf.png"];
        }
        
        
        /*
        NSURL *url = [NSURL URLWithString:currentClip.thumbnail_path];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        cell1.clipImageView.image = image;
         
         if (indexPath.row == 1) {
            cell1.sectionOverlayView.image = [UIImage imageNamed:@"sequenz-verlauf.png"];
         }
         */
        
        
        // load photo images in the background
        __weak DailiesOverviewViewController *weakSelf = self;
        NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                // then set them via the main queue if the cell is still visible.
                if ([weakSelf.myCollectionView.indexPathsForVisibleItems containsObject:indexPath]) {
                
                    DailyOverviewClipCell *cell = (DailyOverviewClipCell *)[weakSelf.myCollectionView cellForItemAtIndexPath:indexPath];
                    
                    
                    NSURL *url = [NSURL URLWithString:currentClip.thumbnail_path_large];
                    NSData *data = [NSData dataWithContentsOfURL:url];
                    UIImage *image = [UIImage imageWithData:data];
                    
                    cell.clipImageView.image = image;
                    
                    /*if (indexPath.row == 1) {
                        cell.sectionOverlayView.image = [UIImage imageNamed:@"sequenz-verlauf.png"];
                    }*/
                }
            });
        }];
        
        [self.thumbnailQueue addOperation:operation];
        
        return cell1;

    }
    
    return nil;
    
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [[xmlDailiesParser dailies] count];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"Selected item %d", indexPath.row);
    
    if(![self connected]) {
        // not connected
        [self showNoInternetConectionAlert];
        
    } else {
    
        Daily *currentDaily = [[xmlDailiesParser dailies] objectAtIndex:indexPath.section];
        NSMutableArray *dailyClips = [currentDaily clips];
        Clip *currentClip = [dailyClips objectAtIndex:indexPath.row];
        
        
        //------------------
        
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"h:m:s"];
        NSDate *date = [formatter dateFromString:currentClip.start];
        
        NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:date];
        NSLog(@"hour: %d", [components hour]);
        NSLog(@"minute: %d", [components minute]);
        NSLog(@"secunde: %d", [components second]);
        
        double timeTotal = ([components hour] * 3600) + ([components minute] * 60 ) + [components second] +1;
        NSTimeInterval clipInterval = timeTotal;
        
        self.currentPlaybackTimeDO = clipInterval;
        
        
        xmlDailyParser = [[XMLDailyParser alloc] loadXMLByURL:@"http://dailies.wefadetogrey.de/api/get/daily.xml" AndDailyIdent:currentDaily.ident AndUserName:userNameDO AndPassword:userPasswordDO];
        
        
        [self performSegueWithIdentifier:@"fromDailiesOverviewToDailyView" sender:self];
    
    }
    
}




- (IBAction)contactBtnClick:(id)sender {
    
    NSLog(@"contactBtnClick-----");
    [self performSegueWithIdentifier:@"fromDailiesOverviewToContact" sender:self];
}

- (IBAction)dailiesBtnClick:(id)sender {
    NSLog(@"dailiesBtnClick-----");
    [self performSegueWithIdentifier:@"fromDailiesOverviewToProjectList" sender:self];
}

- (IBAction)overviewBtnClick:(id)sender {
    NSLog(@"overviewBtnClick-----");
}

- (IBAction)logoutBtnClick:(id)sender {
    
    NSLog(@"logoutBtnClick-----");
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userName"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userPassword"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"isLogin"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"switchValue"];
    
    [self performSegueWithIdentifier:@"fromDailiesOverviewToStart" sender:self];
    
}


- (void)showNoInternetConectionAlert{
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Connection Failed"
                                                   message: @"Please connect to network and try again"
                                                  delegate: self
                                         cancelButtonTitle: @"Close"
                                         otherButtonTitles:nil];
    
    //Show Alert On The View
    [alert show];
    
    
}

- (BOOL)connected {
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return !(networkStatus == NotReachable);
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    
    if([segue.identifier isEqualToString:@"fromDailiesOverviewToContact"]){
        
        ContactViewController *vc = [segue destinationViewController];
        vc.userNameC = self.userNameDO;
        vc.userPasswordC = self.userPasswordDO;
        vc.projectIdentC = self.projectIdent;
        vc.openSectionIndexC = self.openSectionIndexDO;
    }
    
    if([segue.identifier isEqualToString:@"fromDailiesOverviewToProjectList"]){
        
        ProjectsViewControllerNew *vc = [segue destinationViewController];
        vc.userNameP = self.userNameDO;
        vc.userPasswordP = self.userPasswordDO;
        vc.sectionIndex = self.openSectionIndexDO;
    }
    
    if([segue.identifier isEqualToString:@"fromDailiesOverviewToDailyView"]){
        
        DailyViewController *vc = [segue destinationViewController];
        vc.userNameD = self.userNameDO;
        vc.userPasswordD = self.userPasswordDO;
        vc.projectIdent = self.projectIdent;
        
        vc.dailyX = xmlDailyParser.daily;
        
        vc.currentPlaybackTimeD = self.currentPlaybackTimeDO;
        vc.openSectionIndexD = self.openSectionIndexDO;
    }
    
    
    
}


@end
