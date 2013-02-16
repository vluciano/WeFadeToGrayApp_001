
/*
     File: SectionInfo.h
 Abstract: A section info object maintains information about a section:
 * Whether the section is open
 * The header view for the section
 * The model objects for the section -- in this case, the dictionary containing the quotations for a single play
 * The height of each row in the section
 
 //  WeFadeToGrayApp_001
 //
 //  Created by Vladimir Luciano on 1/26/13.
 //  Copyright (c) 2013 Vladimir Luciano. All rights reserved.


 
 */

#import <Foundation/Foundation.h>

@class SectionHeaderView;
@class Project;


@interface SectionInfo : NSObject 

@property (assign) BOOL open;
@property (strong) Project* project;
@property (strong) SectionHeaderView* headerView;

@property (nonatomic,strong,readonly) NSMutableArray *rowHeights;

- (NSUInteger)countOfRowHeights;
- (id)objectInRowHeightsAtIndex:(NSUInteger)idx;
- (void)insertObject:(id)anObject inRowHeightsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromRowHeightsAtIndex:(NSUInteger)idx;
- (void)replaceObjectInRowHeightsAtIndex:(NSUInteger)idx withObject:(id)anObject;
- (void)insertRowHeights:(NSArray *)rowHeightArray atIndexes:(NSIndexSet *)indexes;
- (void)removeRowHeightsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceRowHeightsAtIndexes:(NSIndexSet *)indexes withRowHeights:(NSArray *)rowHeightArray;

@end
