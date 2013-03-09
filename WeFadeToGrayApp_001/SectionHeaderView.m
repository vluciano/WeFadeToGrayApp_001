
/*
     File: SectionHeaderView.m
 Abstract: A view to display a section header, and support opening and closing a section.
 
 Version: 2.0
 
 */

#import "SectionHeaderView.h"
#import <QuartzCore/QuartzCore.h>

@implementation SectionHeaderView


@synthesize disclosureButton=_disclosureButton, delegate=_delegate, section=_section, isDisclosureButtonSelected;


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
        titelText.frame = CGRectMake(30,30,600,26);
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
        [button addTarget:self action:@selector(toggleOpen:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        _disclosureButton = button;

        _section = sectionNumber;
        
        self.layer.borderColor = [UIColor grayColor].CGColor;
        self.layer.borderWidth = 0.5f;
        
        isDisclosureButtonSelected = NO;
        
    }
    
    return self;
    
}


-(IBAction)toggleOpen:(id)sender {
    
    [self toggleOpenWithUserAction:YES];
}

- (void) setDisclosureButtonSelected:(BOOL)value {
    isDisclosureButtonSelected = value;
}


-(void)toggleOpenWithUserAction:(BOOL)userAction {
    
    // Toggle the disclosure button state.
    //self.disclosureButton.selected = !self.disclosureButton.selected;

    isDisclosureButtonSelected = !isDisclosureButtonSelected;
    
    // If this was a user action, send the delegate the appropriate message.
    if (userAction) {
        if (isDisclosureButtonSelected) {
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



-(void)openSection {
    
    if ([self.delegate respondsToSelector:@selector(sectionHeaderView:sectionOpened:)]) {
            [self.delegate sectionHeaderView:self sectionOpened:self.section];
    }
    
}

-(void)closeSection {
    
    if ([self.delegate respondsToSelector:@selector(sectionHeaderView:sectionClosed:)]) {
        [self.delegate sectionHeaderView:self sectionClosed:self.section];
    }
    
}





@end
