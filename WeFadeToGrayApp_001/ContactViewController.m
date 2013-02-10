//
//  ContactViewController.m
//  WeFadeToGrayApp_001
//
//  Created by Vladimir Luciano on 2/7/13.
//  Copyright (c) 2013 Vladimir Luciano. All rights reserved.
//

#import "ContactViewController.h"

@interface ContactViewController ()

@end

@implementation ContactViewController


@synthesize contactHeaderView, contactFooterView, logoutBtn, backBtn, loginUserName, userName;


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
    
    self.loginUserName.text = self.userName;

	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dailiesListBtnClick:(id)sender {
}

- (IBAction)overviewBtnClick:(id)sender {
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
@end
