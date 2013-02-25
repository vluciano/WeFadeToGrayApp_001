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
#import <MediaPlayer/MediaPlayer.h>


@interface DailyViewController ()

@end

@implementation DailyViewController

@synthesize userName, userPassword, projectIdent, headerView, contactBtn, dailiesListBtn, overviewBtn, dailyX;
@synthesize projectName, dailyDate, dailyLengh, dailyName, clipName, projectNameEx, infoView, videoView, moviePlayer;



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

    self.moviePlayer.shouldAutoplay = YES;
    [self.moviePlayer prepareToPlay];
    [self.moviePlayer setFullscreen:YES animated:YES];
    
    [self.videoView addSubview: self.moviePlayer.view];
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
