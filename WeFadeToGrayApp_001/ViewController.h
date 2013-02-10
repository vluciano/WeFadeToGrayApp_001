//
//  ViewController.h
//  WeFadeToGrayApp_001
//
//  Created by Vladimir Luciano on 1/26/13.
//  Copyright (c) 2013 Vladimir Luciano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"

@interface ViewController : UIViewController <DismissPopoverDelegate>

@property (weak, nonatomic) IBOutlet UIButton *startLoginBtn;

@property (strong, nonatomic) UIPopoverController* popControler;

@property (weak, nonatomic) NSString *userName;
@property (weak, nonatomic) NSString *userPassword;


-(IBAction)startLoginBtnClick:(id)sender;





@end
