//
//  LoginViewController.h
//  WeFadeToGrayApp_001
//
//  Created by Vladimir Luciano on 1/26/13.
//  Copyright (c) 2013 Vladimir Luciano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMLLoginParser.h"
#import "User.h"

@protocol DismissPopoverDelegate
- (void) dismissPopover:(BOOL)transferToProjectView withUserName: (NSString *) userName UndPassword:(NSString *) userPass;
@end



@interface LoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *txtUserName;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *ai;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UITextField *txtError;
@property (weak, nonatomic) IBOutlet UISwitch *saveCredentials;


- (IBAction)switchTapped:(id)sender;
- (IBAction)loginBtnClick:(id)sender;
 
- (void) getLoginResponse;


@property (nonatomic, assign) id<DismissPopoverDelegate> delegate;

@end
