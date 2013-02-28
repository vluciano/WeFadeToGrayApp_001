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


@interface DailyViewController ()

@end

@implementation DailyViewController

@synthesize userName, userPassword, projectIdent, headerView, contactBtn, dailiesListBtn, overviewBtn, dailyX;
@synthesize projectName, dailyDate, dailyLengh, dailyName, clipName, projectNameEx, infoView, videoView, moviePlayer, currentPlaybackTime;
@synthesize myCollectionView, thumbnailQueue;



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
	// Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"dailiesOverviewView_bg.png"]];
    self.headerView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"header_bg_pl.png"]];
    self.infoView.backgroundColor = [UIColor clearColor];
    
    self.dailyName.text = self.dailyX.name;
    
    
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
    
    //Video
    NSURL *url = [NSURL URLWithString:self.dailyX.url];
    self.moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:url];
    [self.moviePlayer.view setFrame:CGRectMake(0, 0, 686, 386)];
    
    self.moviePlayer.controlStyle = MPMovieControlStyleDefault;

    self.moviePlayer.shouldAutoplay = NO;
    
    [self.moviePlayer setFullscreen:YES animated:YES];
    
    [self.videoView addSubview: self.moviePlayer.view];
    
    [self.moviePlayer prepareToPlay];

    [self.moviePlayer setCurrentPlaybackTime:-1];
    [self.moviePlayer setInitialPlaybackTime:self.currentPlaybackTime];
    [self.moviePlayer play];
    
    
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
    
    double timeTotal = ([components hour] * 3600) + ([components minute] * 60 ) + [components second];
    NSTimeInterval clipInterval = timeTotal;
    
    self.currentPlaybackTime = clipInterval;
    
    //[self.moviePlayer stop];
    [self.moviePlayer setCurrentPlaybackTime:self.currentPlaybackTime];
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
    
    [self performSegueWithIdentifier:@"fromDailyToDailiesOverviewView" sender:self];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    [self.moviePlayer pause];
    
    
    if([segue.identifier isEqualToString:@"fromDailyToProjectListView"]){
    
        ProjectsViewControllerNew *vc = [segue destinationViewController];
        vc.userName = self.userName;
        vc.userPassword = self.userPassword;
     
    }
    
    if([segue.identifier isEqualToString:@"fromDailyToDailiesOverviewView"]){
        
        DailiesOverviewViewController *vc = [segue destinationViewController];
        vc.userName = self.userName;
        vc.userPassword = self.userPassword;
        vc.projectIdent = self.projectIdent;
        
    }
    
    
    if([segue.identifier isEqualToString:@"fromDailiesOverviewToContact"]){
        
        ContactViewController *vc = [segue destinationViewController];
        vc.userName = self.userName;
    }
}


@end
