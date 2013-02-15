//
//  XMLDailiesParser.h
//  ParseFromServerModul
//
//  Created by Vladimir Luciano on 1/19/13.
//  Copyright (c) 2013 Vladimir Luciano. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Daily.h"
#import "Clip.h"

@interface XMLDailiesParser : NSObject <NSXMLParserDelegate>

@property (strong, readonly) NSMutableArray *dailies;
@property (strong, readonly) NSMutableArray *clips;


-(id) loadXMLByURL:(NSString *)urlString AndProjectIdent:(NSString *) ident AndUserName:(NSString *)user AndPassword:(NSString *)pass;

@end
