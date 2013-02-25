//
//  DailyViewController.h
//  WeFadeToGrayApp_001
//
//  Created by Vladimir Luciano on 2/24/13.
//  Copyright (c) 2013 Vladimir Luciano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Daily.h"
#import <MediaPlayer/MediaPlayer.h>

@interface DailyViewController : UIViewController

@property (weak, nonatomic) NSString *userName;
@property (weak, nonatomic) NSString *userPassword;
@property (weak, nonatomic) NSString *projectIdent;
@property (weak, nonatomic) NSString *projectNameEx;

@property (weak, nonatomic) Daily *dailyX;

@property (strong, nonatomic) IBOutlet UIButton *contactBtn;
@property (strong, nonatomic) IBOutlet UIButton *dailiesListBtn;
@property (strong, nonatomic) IBOutlet UIButton *overviewBtn;
@property (strong, nonatomic) IBOutlet UIView *headerView;

//info
@property (strong, nonatomic) IBOutlet UIView *infoView;
@property (strong, nonatomic) IBOutlet UILabel *projectName;
@property (strong, nonatomic) IBOutlet UILabel *dailyName;
@property (strong, nonatomic) IBOutlet UILabel *dailyDate;
@property (strong, nonatomic) IBOutlet UILabel *dailyLengh;
@property (strong, nonatomic) IBOutlet UILabel *clipName;

//video
@property (strong, nonatomic) IBOutlet UIView *videoView;
@property (strong, nonatomic) MPMoviePlayerController *moviePlayer;


- (IBAction)contactBtnClick:(id)sender;
- (IBAction)dailiesBtnClick:(id)sender;
- (IBAction)overviewBtnClick:(id)sender;


@end
