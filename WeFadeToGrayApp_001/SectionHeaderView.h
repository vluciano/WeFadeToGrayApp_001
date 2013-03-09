
/*
     File: SectionHeaderView.h
 Abstract: A view to display a section header, and support opening and closing a section.
 
  Version: 2.0
 
 */

#import <Foundation/Foundation.h>
#import "Project.h"

@protocol SectionHeaderViewDelegate;


@interface SectionHeaderView : UIView 

@property (nonatomic, weak) UIButton *disclosureButton;
@property (nonatomic, assign) NSInteger section;
@property (nonatomic, weak) id <SectionHeaderViewDelegate> delegate;

@property (nonatomic) Boolean isDisclosureButtonSelected;

- (void) setDisclosureButtonSelected:(BOOL)value;
- (void) openSection;
- (void) closeSection;

-(id)initWithFrame:(CGRect)frame AndProject:(Project*)project section:(NSInteger)sectionNumber delegate:(id <SectionHeaderViewDelegate>)delegate;
-(void)toggleOpenWithUserAction:(BOOL)userAction;

@end



/*
 Protocol to be adopted by the section header's delegate; the section header tells its delegate when the section should be opened and closed.
 */
@protocol SectionHeaderViewDelegate <NSObject>

@optional
-(void)sectionHeaderView:(SectionHeaderView*)sectionHeaderView sectionOpened:(NSInteger)section;
-(void)sectionHeaderView:(SectionHeaderView*)sectionHeaderView sectionClosed:(NSInteger)section;

@end

