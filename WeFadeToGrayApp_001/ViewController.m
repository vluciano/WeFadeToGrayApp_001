//
//  ViewController.m
//  WeFadeToGrayApp_001
//
//  Created by Vladimir Luciano on 1/26/13.
//  Copyright (c) 2013 Vladimir Luciano. All rights reserved.
//

#import "ViewController.h"
#import "ProjectsViewControllerNew.h"
#import "LoginViewController.h"

@interface ViewController ()

@end

@implementation ViewController




@synthesize startLoginBtn, popControler, userName, userPassword;

- (void)viewDidLoad {
    
    [super viewDidLoad];
}

- (void) viewWillAppear:(BOOL)animated {

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) dismissPopover:(BOOL) isTransferToProjectView withUserName: (NSString *) userNameX UndPassword:(NSString *) userPassX {
    
        
    NSLog(@"dismissPopover----");
    
    if(isTransferToProjectView){
        
        self.userName = userNameX;
        self.userPassword = userPassX;
        
        [self.popControler dismissPopoverAnimated:NO];
        [self performSegueWithIdentifier:@"fromStartToProjectListNew" sender:self];
       
    }
    
}


- (IBAction)startLoginBtnClick:(id)sender {
    
    NSLog(@"startLoginBtnClick----");
    
    NSUserDefaults *userPref = [NSUserDefaults standardUserDefaults];
    if ([[userPref objectForKey:@"isLogin"] intValue] == 1) {
        //go to the Project List
        [self performSegueWithIdentifier:@"fromStartToProjectListNew" sender:self];
        
    }else{
        //user not log in - go to the login page
        [self performSegueWithIdentifier:@"fromStartToLogin" sender:self];
    }

}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([segue.identifier isEqualToString:@"fromStartToProjectListNew"]){
        
        NSUserDefaults *userPref = [NSUserDefaults standardUserDefaults];
        
        if ([[userPref objectForKey:@"isLogin"] intValue] == 1) {
            self.userName = [userPref objectForKey:@"userName"];
            self.userPassword = [userPref objectForKey:@"userPassword"];
        }
        

        ProjectsViewControllerNew *vc = [segue destinationViewController];
        vc.userName = self.userName;
        vc.userPassword = self.userPassword;
    }
    
    
    else if ([segue.identifier isEqualToString:@"fromStartToLogin"]){
        
        LoginViewController *vc = (LoginViewController*)[segue destinationViewController];
        vc.delegate = self;
        
        self.popControler = [(UIStoryboardPopoverSegue *)segue popoverController];
        
    }
}









@end
