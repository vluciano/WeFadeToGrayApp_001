//
//  ViewController.h
//  WeFadeToGrayApp_001
//
//  Created by Vladimir Luciano on 1/26/13.
//  Copyright (c) 2013 Vladimir Luciano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSKeyboardControls.h"

@interface ViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate, BSKeyboardControlsDelegate>

@property (weak, nonatomic) IBOutlet UIButton *startLoginBtn;
@property (strong, nonatomic) IBOutlet UIImageView *logoStartView;
@property (strong, nonatomic) IBOutlet UIView *loginView;

@property (strong, nonatomic) IBOutlet UITextField *txtUserName;
@property (strong, nonatomic) IBOutlet UITextField *txtPassword;
@property (strong, nonatomic) IBOutlet UITextField *txtError;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *ai;

@property (weak, nonatomic) NSString *userNameS;
@property (weak, nonatomic) NSString *userPasswordS;

@property (strong, nonatomic) IBOutlet UIButton *saveCredentialsBtn;

- (IBAction)saveCredentialsTapped:(UIButton *)button;
- (IBAction)startLoginBtnClick:(id)sender;

- (void) getLoginResponse;
- (BOOL)connected;
- (void) showNoInternetConectionAlert;
- (NSString *) md5:(NSString *) input;

@end
