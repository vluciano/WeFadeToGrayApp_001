//
//  ViewController.m
//  WeFadeToGrayApp_001
//
//  Created by Vladimir Luciano on 1/26/13.
//  Copyright (c) 2013 Vladimir Luciano. All rights reserved.
//

#import "ViewController.h"
#import "ProjectsViewControllerNew.h"
#import "XMLLoginParser.h"
#import "Reachability.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import <CommonCrypto/CommonDigest.h>
#import "BSKeyboardControls.h"

@interface ViewController ()
@property (nonatomic, strong) BSKeyboardControls *keyboardControls;
@end

@implementation ViewController

@synthesize startLoginBtn, userNameS, userPasswordS, logoStartView, loginView;
@synthesize txtError, txtPassword, txtUserName, saveCredentialsBtn, ai;

XMLLoginParser *xmlLoginParser;
bool saveCredentialsValue = NO;



- (void)viewDidLoad {
    
    [super viewDidLoad];
    NSLog(@"viewDidLoad - ViewController");
    
    ai.hidesWhenStopped = YES;
    [ai setHidden:YES];
    
    NSUserDefaults *userPref = [NSUserDefaults standardUserDefaults];
    bool valueOfSaveCredentials = [[userPref objectForKey:@"switchValue"] intValue];
    
    NSLog(@"valueOfSaveCredentials from userPref: %i", valueOfSaveCredentials);
    [saveCredentialsBtn setSelected:valueOfSaveCredentials];
    saveCredentialsValue = valueOfSaveCredentials;
    
    NSArray *fields = @[self.txtUserName, self.txtPassword];
    
    [self setKeyboardControls:[[BSKeyboardControls alloc] initWithFields:fields]];
    [self.keyboardControls setDelegate:self];
    
}

- (void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
    NSLog(@"viewWillAppear - ViewController");
    NSUserDefaults *userPref = [NSUserDefaults standardUserDefaults];
    if ([[userPref objectForKey:@"isLogin"] intValue] == 1) {
        [self.startLoginBtn setHidden:YES];
    }else {
        [self.startLoginBtn setHidden:NO];
    }
    
    self.loginView.alpha = 0;
    self.logoStartView.alpha = 0;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:self.view.window];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:self.view.window];
    
    
}

- (void) viewDidAppear:(BOOL)animated {
    
    NSLog(@"viewDidAppear - ViewController");
    NSUserDefaults *userPref = [NSUserDefaults standardUserDefaults];
    
    if(![self connected]) {
        // not connected
        [self showNoInternetConectionAlert];
    } else {
        
        if ([[userPref objectForKey:@"isLogin"] intValue] == 1) {
            //go to the Project List
            [self performSegueWithIdentifier:@"fromStartToProjectListNew" sender:self];
            
        }
    }
    
   
    [UIView animateWithDuration:1.0 delay:1 options:UIViewAnimationTransitionNone animations:^{
        self.logoStartView.alpha = 1;
    } completion:^(BOOL finished) {
                
        [UIView animateWithDuration:1.5 animations:^{
            self.loginView.alpha = 1;
        } completion:^(BOOL finished) {
            
        }];

    }];

}

- (void)viewWillDisappear:(BOOL)animated {
    [self setEditing:NO animated:YES];
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil]; 
}



- (void) getLoginResponse {
    
    NSString *outputMD5Str;
    outputMD5Str = [self md5:txtPassword.text];
    
    xmlLoginParser = [[XMLLoginParser alloc] loadXMLByURL:@"http://dailies.wefadetogrey.de/api/get/login.xml" andUser:txtUserName.text andPassword:outputMD5Str];
    
    if (xmlLoginParser.userName.length > 0 && xmlLoginParser.errorDescription != (id)[NSNull null] ) {
        
        NSLog(@"userId: %@", xmlLoginParser.userId);
        NSLog(@"userName: %@",xmlLoginParser.userName);
        NSLog(@"errorDescription: %@",xmlLoginParser.errorDescription);
        
        //save the credentials
        userNameS = [self.txtUserName text];
        userPasswordS = outputMD5Str;
        
        if (saveCredentialsValue) {
            
            NSUserDefaults *userPref = [NSUserDefaults standardUserDefaults];
            [userPref setObject:userNameS forKey:@"userName"];
            [userPref setObject:userPasswordS forKey:@"userPassword"];
            [userPref setInteger:1 forKey:@"isLogin"];
            
            [userPref synchronize];
            NSLog(@"User Data saved");
            
        }
        
        //go to the Project List
        [self performSegueWithIdentifier:@"fromStartToProjectListNew" sender:self];
        
        
    }else {
        NSLog(@"Error: %@", xmlLoginParser.errorDescription);
        txtError.text = xmlLoginParser.errorDescription;
        startLoginBtn.enabled = YES;
    }
    
    [ai stopAnimating];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveCredentialsTapped:(UIButton *)button {
    
    NSLog(@"saveCredentialsTapped----");
    button.selected = !button.selected;
    
    saveCredentialsValue = button.selected;
    
    //persist the savecredentials value
    NSUserDefaults *userPref = [NSUserDefaults standardUserDefaults];
    [userPref setInteger:saveCredentialsValue forKey:@"switchValue"];
    [userPref synchronize];

}

- (IBAction)startLoginBtnClick:(id)sender {
    
    NSLog(@"startLoginBtnClick----");
    
    if(![self connected]) {
        // not connected
        [self showNoInternetConectionAlert];
         
    }else {
        
        if(txtUserName.text.length < 3 || txtPassword.text.length < 3){
            txtError.text = @"Please fill the fields correctly";
        }else {
            
            [ai setHidden:NO];
            [ai startAnimating];
            startLoginBtn.enabled = FALSE;
            
            [self performSelector:@selector(getLoginResponse) withObject:nil afterDelay:0];
        }

    }
    
    
}

- (IBAction)switchTapped:(id)sender {
    
        
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([segue.identifier isEqualToString:@"fromStartToProjectListNew"]){
        
        NSUserDefaults *userPref = [NSUserDefaults standardUserDefaults];
        
        if ([[userPref objectForKey:@"isLogin"] intValue] == 1) {
            userNameS = [userPref objectForKey:@"userName"];
            userPasswordS = [userPref objectForKey:@"userPassword"];
        }
        
        
        ProjectsViewControllerNew *vc = [segue destinationViewController];
        vc.userNameP = userNameS;
        vc.userPasswordP = userPasswordS;
    }    
}


#pragma mark -
#pragma mark Text Field Delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.keyboardControls setActiveField:textField];
}

#pragma mark -
#pragma mark Text View Delegate

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [self.keyboardControls setActiveField:textView];
}

#pragma mark -
#pragma mark Keyboard Controls Delegate

- (void)keyboardControls:(BSKeyboardControls *)keyboardControls directionPressed:(BSKeyboardControlsDirection)direction {
    
}

- (void)keyboardControlsDonePressed:(BSKeyboardControls *)keyboardControls
{
    [keyboardControls.activeField resignFirstResponder];
}


# pragma mark -
# pragma mark UITextViewDelegate

- (void)keyboardWillShow:(NSNotification *)notif {
    NSLog(@"keyboardWillShow...");
    
    [UIView animateWithDuration:0.5 delay:0.0f options:UIViewAnimationTransitionNone animations:^{
        self.loginView.frame = CGRectMake(0.0f, 20.0f, self.loginView.frame.size.width, self.loginView.frame.size.height);
        self.logoStartView.frame = CGRectMake(332.0f, -255.0f, self.logoStartView.frame.size.width, self.logoStartView.frame.size.height);
        
    } completion:^(BOOL finished) {
        NSLog(@"animation Finish...");
        
    }];
    
}


-(void)keyboardWillHide:(NSNotification *)notification {
    NSLog(@"keyboardWillHide...");
    
    [UIView animateWithDuration:0.5 delay:0.0f options:UIViewAnimationTransitionNone animations:^{
        self.loginView.frame = CGRectMake(0.0f, 384.0f, self.loginView.frame.size.width, self.loginView.frame.size.height);
        self.logoStartView.frame = CGRectMake(332.0f, 110.0f, self.logoStartView.frame.size.width, self.logoStartView.frame.size.height);

    } completion:^(BOOL finished) {
        NSLog(@"animation Finish...");
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

- (NSString *) md5:(NSString *) input
{
    const char *cStr = [input UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
    
}



@end
