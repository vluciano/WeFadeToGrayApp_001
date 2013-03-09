//
//  ContactViewController.m
//  WeFadeToGrayApp_001
//
//  Created by Vladimir Luciano on 2/7/13.
//  Copyright (c) 2013 Vladimir Luciano. All rights reserved.
//

#import "ContactViewController.h"
#import "DailiesOverviewViewController.h"
#import "ProjectsViewControllerNew.h"

@interface ContactViewController ()

@end

@implementation ContactViewController


@synthesize contactHeaderView, contactFooterView, logoutBtn, loginUserName, userNameC, userPasswordC, openSectionIndexC, projectIdentC;

@synthesize telBtn;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.contactHeaderView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"header_bg_pl.png"]];
    self.contactFooterView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"footer_bg_pl.png"]];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bc_contact.png"]];
    
    self.loginUserName.text = self.userNameC;
    
    self.telBtn.hidden = YES;

	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dailiesListBtnClick:(id)sender {
     [self performSegueWithIdentifier:@"fromContactToProjectList" sender:self];
}

- (IBAction)overviewBtnClick:(id)sender {
    [self performSegueWithIdentifier:@"fromContactToDailyOverview" sender:self];
}

- (IBAction)backBtnClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)logoutBtnClick:(id)sender {
    
    NSLog(@"logoutBtnClick-----");
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userName"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userPassword"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"isLogin"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"switchValue"];
    
    [self performSegueWithIdentifier:@"fromContactToStart" sender:self];

}

- (IBAction)telBtnClick:(id)sender {
    NSLog(@"telBtnClick-----");
    [[UIApplication sharedApplication]  openURL: [NSURL URLWithString: @"tel:+49221998088320"]];
}

- (IBAction)mapBtnClick:(id)sender {
    NSLog(@"mapBtnClick-----");
    [[UIApplication sharedApplication]  openURL: [NSURL URLWithString: @"http://maps.apple.com/?q=Hansaring+88,50670,cologne,germany"]];
    
}

- (IBAction)mailBtnClick:(id)sender {
    NSLog(@"mailBtnClick-----");
    [[UIApplication sharedApplication]  openURL: [NSURL URLWithString: @"mailto:info@wefadetogrey.de"]];
}

- (IBAction)webBtnClick:(id)sender {
    NSLog(@"webBtnClick-----");
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://www.wefadetogrey.de/"]];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
       
    if([segue.identifier isEqualToString:@"fromContactToProjectList"]){
        
        ProjectsViewControllerNew *vc = [segue destinationViewController];
        vc.userNameP = self.userNameC;
        vc.userPasswordP = self.userPasswordC;
        vc.sectionIndex = self.openSectionIndexC;
        
    }
    
    if([segue.identifier isEqualToString:@"fromContactToDailyOverview"]){
        
        DailiesOverviewViewController *vc = [segue destinationViewController];
        vc.userNameDO = self.userNameC;
        vc.userPasswordDO = self.userPasswordC;
        vc.projectIdent = self.projectIdentC;
        vc.openSectionIndexDO = self.openSectionIndexC;
    }
    
    
}





@end
