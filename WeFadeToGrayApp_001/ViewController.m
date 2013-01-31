//
//  ViewController.m
//  WeFadeToGrayApp_001
//
//  Created by Vladimir Luciano on 1/26/13.
//  Copyright (c) 2013 Vladimir Luciano. All rights reserved.
//

#import "ViewController.h"
#import "ProjectsViewControllerNew.h"

@interface ViewController ()

@end

@implementation ViewController


@synthesize startLoginBtn;

- (void)viewDidLoad {
    
    [super viewDidLoad];
}

- (void) viewWillAppear:(BOOL)animated {

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        
        NSString *userName = [userPref objectForKey:@"userName"];
        NSString *userPass = [userPref objectForKey:@"userPassword"];

        
        ProjectsViewControllerNew *vc = [segue destinationViewController];
        vc.userName = userName;
        vc.userPassword = userPass;
    }
}

@end
