//
//  DailieOverviewViewController.h
//  WeFadeToGrayApp_001
//
//  Created by Vladimir Luciano on 2/11/13.
//  Copyright (c) 2013 Vladimir Luciano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMLDailiesParser.h"
#import "XMLDailyParser.h"



@interface DailiesOverviewViewController : UIViewController


@property (weak, nonatomic) NSString *userName;
@property (weak, nonatomic) NSString *userPassword;
@property (weak, nonatomic) NSString *projectIdent;

@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIView *footerView;
@property (weak, nonatomic) IBOutlet UIButton *contactBtn;
@property (weak, nonatomic) IBOutlet UIButton *dailiesListBtn;
@property (weak, nonatomic) IBOutlet UIButton *overviewBtn;
@property (weak, nonatomic) IBOutlet UIButton *logoutBtn;
@property (weak, nonatomic) IBOutlet UILabel *loginUserName;

@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;
@property (nonatomic, strong) NSOperationQueue *thumbnailQueue;

@property(nonatomic) NSTimeInterval currentPlaybackTime;

- (IBAction)contactBtnClick:(id)sender;
- (IBAction)dailiesBtnClick:(id)sender;
- (IBAction)overviewBtnClick:(id)sender;
- (IBAction)logoutBtnClick:(id)sender;


@end
