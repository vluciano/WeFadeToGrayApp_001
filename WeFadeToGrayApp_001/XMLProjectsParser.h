//
//  XMLProjectsParser2.h
//  ParseFromServerModul
//
//  Created by Vladimir Luciano on 1/13/13.
//  Copyright (c) 2013 Vladimir Luciano. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Project.h"
#import "DailySimple.h"

@interface XMLProjectsParser : NSObject <NSXMLParserDelegate>

@property (strong, readonly) NSMutableArray *projects;
@property (strong, readonly) NSMutableArray *dailies;

-(id) loadXMLByURL:(NSString *)urlString AnduserName:(NSString *)user AndPassword:(NSString *)pass;

@end
