//
//  XMLDailyParser.h
//  WeFadeToGrayApp_001
//
//  Created by Vladimir Luciano on 2/24/13.
//  Copyright (c) 2013 Vladimir Luciano. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Daily.h"
#import "Clip.h"

@interface XMLDailyParser : NSObject<NSXMLParserDelegate>

@property (strong, readonly) NSMutableArray *clips;
@property (strong, readonly) Daily *daily;


-(id) loadXMLByURL:(NSString *)urlString AndDailyIdent:(NSString *) ident AndUserName:(NSString *)user AndPassword:(NSString *)pass;


@end
