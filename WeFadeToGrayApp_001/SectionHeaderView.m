
/*
     File: SectionHeaderView.m
 Abstract: A view to display a section header, and support opening and closing a section.
 
  Version: 2.0
 
 Disclaimer: IMPORTANT:  This Apple software is supplied to you by Apple
 Inc. ("Apple") in consideration of your agreement to the following
 terms, and your use, installation, modification or redistribution of
 this Apple software constitutes acceptance of these terms.  If you do
 not agree with these terms, please do not use, install, modify or
 redistribute this Apple software.
 
 In consideration of your agreement to abide by the following terms, and
 subject to these terms, Apple grants you a personal, non-exclusive
 license, under Apple's copyrights in this original Apple software (the
 "Apple Software"), to use, reproduce, modify and redistribute the Apple
 Software, with or without modifications, in source and/or binary forms;
 provided that if you redistribute the Apple Software in its entirety and
 without modifications, you must retain this notice and the following
 text and disclaimers in all such redistributions of the Apple Software.
 Neither the name, trademarks, service marks or logos of Apple Inc. may
 be used to endorse or promote products derived from the Apple Software
 without specific prior written permission from Apple.  Except as
 expressly stated in this notice, no other rights or licenses, express or
 implied, are granted by Apple herein, including but not limited to any
 patent rights that may be infringed by your derivative works or by other
 works in which the Apple Software may be incorporated.
 
 The Apple Software is provided by Apple on an "AS IS" basis.  APPLE
 MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION
 THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS
 FOR A PARTICULAR PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND
 OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS.
 
 IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL
 OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION,
 MODIFICATION AND/OR DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED
 AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE),
 STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGE.
 
 Copyright (C) 2011 Apple Inc. All Rights Reserved.
 
 */

#import "SectionHeaderView.h"
#import <QuartzCore/QuartzCore.h>

@implementation SectionHeaderView


@synthesize disclosureButton=_disclosureButton, delegate=_delegate, section=_section;



-(id)initWithFrame:(CGRect)frame AndProject:(Project*)currentProject section:(NSInteger)sectionNumber delegate:(id <SectionHeaderViewDelegate>)delegate {
    
    self = [super initWithFrame:frame];
    
    if (self != nil) {
        
        // Set up the tap gesture recognizer.
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toggleOpen:)];
        [self addGestureRecognizer:tapGesture];

        _delegate = delegate;        
        self.userInteractionEnabled = YES;
        
        
        // create the parent view that will hold header Label
        
        [self setBackgroundColor:[UIColor blackColor]];
        
        UIColor *myColor = [UIColor colorWithRed:255.0/255.0 green:237.0/255.0 blue:0.0/255.0 alpha:1];
        
        // create the label objects
        UILabel *titelText = [[UILabel alloc] initWithFrame:CGRectZero];
        titelText.backgroundColor = [UIColor clearColor];
        titelText.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
        titelText.frame = CGRectMake(30,30,600,20);
        titelText.text =  currentProject.name;
        titelText.textColor = myColor;
        
        //---------------------------------------//
        UILabel *productionLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        productionLabel.backgroundColor = [UIColor clearColor];
        productionLabel.textColor = [UIColor whiteColor];
        productionLabel.text = @"Production";
        productionLabel.font = [UIFont fontWithName:@"Helvetica" size:10];
        productionLabel.frame = CGRectMake(30,70,150,20);
        
        UILabel *productionText = [[UILabel alloc] initWithFrame:CGRectZero];
        productionText.backgroundColor = [UIColor clearColor];
        productionText.font = [UIFont fontWithName:@"Helvetica" size:13];
        productionText.frame = CGRectMake(30,90,200,20);
        productionText.text =  currentProject.production;
        productionText.textColor = myColor;
        
        //---------------------------------------//
        
        
        UILabel *directorLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        directorLabel.backgroundColor = [UIColor clearColor];
        directorLabel.textColor = [UIColor whiteColor];
        directorLabel.text = @"Director";
        directorLabel.font = [UIFont fontWithName:@"Helvetica" size:10];
        directorLabel.frame = CGRectMake(300,70,150,20);
        
        UILabel *directorText = [[UILabel alloc] initWithFrame:CGRectZero];
        directorText.backgroundColor = [UIColor clearColor];
        directorText.font = [UIFont fontWithName:@"Helvetica" size:13];
        directorText.frame = CGRectMake(300,90,200,20);
        directorText.text =  currentProject.director;
        directorText.textColor = myColor;
        
        
        //---------------------------------------//
        
        
        UILabel *dopLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        dopLabel.backgroundColor = [UIColor clearColor];
        dopLabel.textColor = [UIColor whiteColor];
        dopLabel.text = @"DoP";
        dopLabel.font = [UIFont fontWithName:@"Helvetica" size:10];
        dopLabel.frame = CGRectMake(600,70,150,20);
        
        UILabel *dopText = [[UILabel alloc] initWithFrame:CGRectZero];
        dopText.backgroundColor = [UIColor clearColor];
        dopText.font = [UIFont fontWithName:@"Helvetica" size:13];
        dopText.frame = CGRectMake(600,90,200,20);
        dopText.text =  currentProject.dop;
        dopText.textColor = myColor;
        
        //---------------------------------------//
        
        
        [self addSubview:titelText];
        
        [self addSubview:productionLabel];
        [self addSubview:productionText];
        
        [self addSubview:directorLabel];
        [self addSubview:directorText];
        
        [self addSubview:dopLabel];
        [self addSubview:dopText];

        
        // Create and configure the disclosure button.
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0.0, 5.0, 35.0, 35.0);
        [button setImage:[UIImage imageNamed:@"carat.png"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"carat-open.png"] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(toggleOpen:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        _disclosureButton = button;

        _section = sectionNumber;
        
        
        self.layer.borderColor = [UIColor grayColor].CGColor;
        self.layer.borderWidth = 1.0f;
                
    }
    
    return self;
    
}


-(IBAction)toggleOpen:(id)sender {
    
    [self toggleOpenWithUserAction:YES];
}


-(void)toggleOpenWithUserAction:(BOOL)userAction {
    
    // Toggle the disclosure button state.
    self.disclosureButton.selected = !self.disclosureButton.selected;
    
    // If this was a user action, send the delegate the appropriate message.
    if (userAction) {
        if (self.disclosureButton.selected) {
            if ([self.delegate respondsToSelector:@selector(sectionHeaderView:sectionOpened:)]) {
                [self.delegate sectionHeaderView:self sectionOpened:self.section];
            }
        }
        else {
            if ([self.delegate respondsToSelector:@selector(sectionHeaderView:sectionClosed:)]) {
                [self.delegate sectionHeaderView:self sectionClosed:self.section];
            }
        }
    }
}




@end
