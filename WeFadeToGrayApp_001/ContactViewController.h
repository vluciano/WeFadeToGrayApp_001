//
//  ContactViewController.h
//  WeFadeToGrayApp_001
//
//  Created by Vladimir Luciano on 2/7/13.
//  Copyright (c) 2013 Vladimir Luciano. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *contactHeaderView;
@property (weak, nonatomic) IBOutlet UIView *contactFooterView;
@property (weak, nonatomic) IBOutlet UIButton *dailiesListBtn;
@property (weak, nonatomic) IBOutlet UIButton *overviewBtn;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UIButton *logoutBtn;
@property (weak, nonatomic) IBOutlet UILabel *loginUserName;
@property (weak, nonatomic) NSString *userName;

- (IBAction)dailiesListBtnClick:(id)sender;
- (IBAction)overviewBtnClick:(id)sender;
- (IBAction)backBtnClick:(id)sender;
- (IBAction)logoutBtnClick:(id)sender;

@end
