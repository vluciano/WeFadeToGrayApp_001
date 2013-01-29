//
//  LoginViewController.m
//  WeFadeToGrayApp_001
//
//  Created by Vladimir Luciano on 1/26/13.
//  Copyright (c) 2013 Vladimir Luciano. All rights reserved.
//

#import "LoginViewController.h"
#import "XMLLoginParser.h"
#import "ProjectsViewController.h"

@interface LoginViewController ()
    
@end

@implementation LoginViewController

@synthesize txtPassword, txtUserName, ai, loginBtn, txtError, saveCredentials;


XMLLoginParser *xmlLoginParser;
bool switchValue = NO;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    ai.hidesWhenStopped = YES;
    [ai setHidden:YES];
    
    NSUserDefaults *userPref = [NSUserDefaults standardUserDefaults];
    bool valueOfSwitch = [[userPref objectForKey:@"switchValue"] intValue];
    NSLog(@"swithValues from userPref: %i", valueOfSwitch);
    [saveCredentials setOn:valueOfSwitch];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) getLoginResponse {
    
    xmlLoginParser = [[XMLLoginParser alloc] loadXMLByURL:@"http://dailies.wefadetogrey.de/api/get/login.xml" andUser:txtUserName.text andPassword:txtPassword.text];
    
    if (xmlLoginParser.userName.length > 0 && xmlLoginParser.errorDescription != (id)[NSNull null] ) {
        
        NSLog(@"userId: %@", xmlLoginParser.userId);
        NSLog(@"userName: %@",xmlLoginParser.userName);
        NSLog(@"errorDescription: %@",xmlLoginParser.errorDescription);
        
        //save the credentials
        
        if (switchValue) {
            
            NSString *userName = [txtUserName text];
            NSString *userPass = [txtPassword text];
            
            NSUserDefaults *userPref = [NSUserDefaults standardUserDefaults];
            [userPref setObject:userName forKey:@"userName"];
            [userPref setObject:userPass forKey:@"userPassword"];
            [userPref setInteger:1 forKey:@"isLogin"];
            
            [userPref synchronize];
            NSLog(@"User Data saved");

        }
        
        
        //go to the Project List
        [self performSegueWithIdentifier:@"fromLoginToProjectListNew" sender:self];
        
        
    }else {
        NSLog(@"Error: %@", xmlLoginParser.errorDescription);
        txtError.text = xmlLoginParser.errorDescription;
        loginBtn.enabled = YES;
    }
    
    [ai stopAnimating];
}



- (IBAction)loginBtnClick:(id)sender {
    
    NSLog(@"loginBtnClick----");
    
    if(txtUserName.text.length < 3 || txtPassword.text.length < 3){
        txtError.text = @"Please fill the fields correctly";
    }else {
        [ai setHidden:NO];
        [ai startAnimating];
        loginBtn.enabled = FALSE;
        
        [self performSelector:@selector(getLoginResponse) withObject:nil afterDelay:0];
    }
}


-(IBAction) switchTapped: (id) sender {
    UISwitch *switchControl = (UISwitch*) sender;
    switchValue = switchControl.isOn;
    
    //persist the switch value
    NSUserDefaults *userPref = [NSUserDefaults standardUserDefaults];
    [userPref setInteger:switchValue forKey:@"switchValue"];
    [userPref synchronize];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    NSString *userName = [txtUserName text];
    NSString *userPass = [txtPassword text];
    
    if([segue.identifier isEqualToString:@"fromLoginToProjectListNew"]){
        
        ProjectsViewController *vc = [segue destinationViewController];
        vc.userName = userName;
        vc.userPassword = userPass;
    }
}



@end
