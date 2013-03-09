//
//  DailyViewController.m
//  WeFadeToGrayApp_001
//
//  Created by Vladimir Luciano on 2/24/13.
//  Copyright (c) 2013 Vladimir Luciano. All rights reserved.
//

#import "DailyViewController.h"
#import "ContactViewController.h"
#import "ProjectsViewControllerNew.h"
#import "DailiesOverviewViewController.h"
#import "DailyClipCell.h"
#import <MediaPlayer/MediaPlayer.h>
#import "Reachability.h"
#import <SystemConfiguration/SystemConfiguration.h>

@interface DailyViewController ()

@end

@implementation DailyViewController

@synthesize userNameD, userPasswordD, projectIdent, headerView, contactBtn, dailiesListBtn, overviewBtn, dailyX;
@synthesize projectName, dailyDate, dailyLengh, dailyName, clipName, projectNameEx, infoView, videoView, moviePlayer, currentPlaybackTimeD;
@synthesize myCollectionView, thumbnailQueue;

@synthesize commentView, commentBtn, commentWebView, openSectionIndexD;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        NSLog(@"initWithNibName");
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [self.view addSubview:self.commentView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"dailiesOverviewView_bg.png"]];
    self.headerView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"header_bg_pl.png"]];
    self.infoView.backgroundColor = [UIColor clearColor];
    self.commentView.backgroundColor = [UIColor colorWithRed:255 green:237 blue:0 alpha:1];
    self.commentWebView.backgroundColor = [UIColor colorWithRed:255 green:237 blue:0 alpha:1];
    self.dailyName.text = self.dailyX.name;
    
    
    [self.commentView setFrame:CGRectMake(0.0f, 748.0f, self.commentView.frame.size.width, self.commentView.frame.size.height)];
    [[self commentView] setCenter:CGPointMake(0.0f, 748.0f)];
    self.commentView.hidden = false;
    
    NSLog(@"self.commentView.frame.origin.x:  %f", self.commentView.frame.origin.x);
    NSLog(@"self.commentView.frame.origin.y:  %f", self.commentView.frame.origin.y);

    
    
    //DATE LABEL
    NSString * timeStampString = self.dailyX.created;
    double _interval = (double)[timeStampString doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:(_interval)];
    //NSLog(@"%@", date);
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSLocale *de_DE = [[NSLocale alloc] initWithLocaleIdentifier:@"de_DE"];
    
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
    [dateFormatter setDateFormat:@"dd.MM.yyyy - HH:mm"];
    [dateFormatter setLocale:de_DE];
    
    
    NSString *stringFromDate = [dateFormatter stringFromDate:date];
    //NSLog(@"stringFromDate: %@", stringFromDate);
    

    self.dailyDate.text = stringFromDate;
    
    self.dailyLengh.text = self.dailyX.sec_duration;
    self.projectName.text = self.projectNameEx;
    self.clipName.text = self.dailyX.sec_name;
    
    self.commentWebView.backgroundColor  = [UIColor clearColor];
    
    NSLog(@"-----> %@",self.dailyX.comment);
    NSString *commentContent = [NSString stringWithFormat:@"<html><body style=\"font-size:12px;font-family:Helvetica;\"><div id=\"content\">%@</div></body></html>", self.dailyX.comment];
    
    [self.commentWebView loadHTMLString:commentContent baseURL:[NSURL URLWithString:@""]];
    
    //Video
    NSURL *url = [NSURL URLWithString:self.dailyX.url];
    self.moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:url];
    //[self.moviePlayer.view setFrame:CGRectMake(0, 0, 686, 386)];
    [self.moviePlayer.view setFrame:CGRectMake(0, 0, 753, 424)];
    
    self.moviePlayer.controlStyle = MPMovieControlStyleDefault;

    self.moviePlayer.shouldAutoplay = NO;
    
    [self.moviePlayer setFullscreen:YES animated:YES];
    
    [self.videoView addSubview: self.moviePlayer.view];
    
    [self.moviePlayer prepareToPlay];

    [self.moviePlayer setCurrentPlaybackTime:-1];
    [self.moviePlayer setInitialPlaybackTime:self.currentPlaybackTimeD];
    [self.moviePlayer play];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayerPlaybackStateChanged:) name:MPMoviePlayerPlaybackStateDidChangeNotification object:nil];
    
    
    
    //UICollection
    self.myCollectionView.backgroundColor = [UIColor clearColor];
    [self.myCollectionView registerClass:[DailyClipCell class] forCellWithReuseIdentifier:@"ClipCell"];
    self.myCollectionView.pagingEnabled = NO;
    
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout*)self.myCollectionView.collectionViewLayout;
    flowLayout.itemSize = CGSizeMake(135, 105);
    [flowLayout setMinimumInteritemSpacing:0.f];
    [flowLayout setMinimumLineSpacing:0.f];
    
    self.thumbnailQueue = [[NSOperationQueue alloc] init];
    self.thumbnailQueue.maxConcurrentOperationCount = NSOperationQueueDefaultMaxConcurrentOperationCount;
    
    [self.myCollectionView reloadData];
    
}

-(void)moviePlayerPlaybackStateChanged:(NSNotification *)notification {
    /*MPMoviePlayerController moviePlayer = notification.object;
    MPMoviePlaybackState playbackState = moviePlayer.playbackState;
    NSLog(@"playbackState: %i", playbackState);
    */ 
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    NSInteger numClipsInDaily = [[self.dailyX clips] count];
    return numClipsInDaily;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSMutableArray *dailyClips = [self.dailyX clips];
    Clip *currentClip = [dailyClips objectAtIndex:indexPath.row];
    
    static NSString *identifier;
    identifier = @"ClipCell";
        
    DailyClipCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.clipTitel.text = currentClip.clipName;
    
    /*
    NSURL *url = [NSURL URLWithString:currentClip.thumbnail_path];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    cell.clipImageView.image = image;
    */
        
        
    // load photo images in the background
    __weak DailyViewController *weakSelf = self;
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // then set them via the main queue if the cell is still visible.
            if ([weakSelf.myCollectionView.indexPathsForVisibleItems containsObject:indexPath]) {
                
                DailyClipCell *cell = (DailyClipCell *)[weakSelf.myCollectionView cellForItemAtIndexPath:indexPath];
                
                NSURL *url = [NSURL URLWithString:currentClip.thumbnail_path_large];
                NSData *data = [NSData dataWithContentsOfURL:url];
                UIImage *image = [UIImage imageWithData:data];
                
                cell.clipImageView.image = image;
                
            }
        });
    }];
    
        [self.thumbnailQueue addOperation:operation];
        
        return cell;
    
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"Selected item %d", indexPath.row);
    
    NSMutableArray *dailyClips = [self.dailyX clips];
    Clip *currentClip = [dailyClips objectAtIndex:indexPath.row];

    //------------------
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"h:m:s"];
    NSDate *date = [formatter dateFromString:currentClip.start];
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:date];
    NSLog(@"hour: %d", [components hour]);
    NSLog(@"minute: %d", [components minute]);
    NSLog(@"secunde: %d", [components second]);
    
    double timeTotal = ([components hour] * 3600) + ([components minute] * 60 ) + [components second] + 1;
    NSTimeInterval clipInterval = timeTotal;
    
    self.currentPlaybackTimeD = clipInterval;
    
    //[self.moviePlayer stop];
    [self.moviePlayer setCurrentPlaybackTime:self.currentPlaybackTimeD];
    [self.moviePlayer play];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)contactBtnClick:(id)sender {
    [self performSegueWithIdentifier:@"fromDailyViewToContact" sender:self];
}

- (IBAction)dailiesBtnClick:(id)sender {
    
    [self performSegueWithIdentifier:@"fromDailyToProjectListView" sender:self];
}

- (IBAction)overviewBtnClick:(id)sender {
    
    
    if(![self connected]) {
        // not connected
        [self showNoInternetConectionAlert];
        
    } else {
       [self performSegueWithIdentifier:@"fromDailyToDailiesOverviewView" sender:self]; 
    }
    
}


- (IBAction)showCommentViewAction:(id)sender {
    
    NSLog(@"showCommentViewAction");
    
    NSLog(@"y: %f", self.commentView.frame.origin.y);
    
    double yAchse = 748.0f;
    if(self.commentView.frame.origin.y == 748.0f){
         yAchse = 673.0f;
    }else {
        yAchse = 748.0f;
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        self.commentView.frame = CGRectMake(0.0f, yAchse, self.commentView.frame.size.width, self.commentView.frame.size.height);
    } completion:^(BOOL finished) {
        
    }];

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
    
    [self.moviePlayer pause];
    
    
    if([segue.identifier isEqualToString:@"fromDailyToProjectListView"]){
    
        ProjectsViewControllerNew *vc = [segue destinationViewController];
        vc.userNameP = self.userNameD;
        vc.userPasswordP = self.userPasswordD;
        vc.sectionIndex = self.openSectionIndexD;
     
    }
    
    if([segue.identifier isEqualToString:@"fromDailyToDailiesOverviewView"]){
        
        DailiesOverviewViewController *vc = [segue destinationViewController];
        vc.userNameDO = self.userNameD;
        vc.userPasswordDO = self.userPasswordD;
        vc.projectIdent = self.projectIdent;
        vc.openSectionIndexDO = self.openSectionIndexD;
    }
    
    
    if([segue.identifier isEqualToString:@"fromDailiesOverviewToContact"]){
        
        ContactViewController *vc = [segue destinationViewController];
        vc.userNameC = self.userNameD;
        vc.userPasswordC = self.userPasswordD;
        vc.projectIdentC = self.projectIdent;
        vc.openSectionIndexC = self.openSectionIndexD;
    }
}






@end
