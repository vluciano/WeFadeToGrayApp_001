//
//  XMLLoginParser.h
//  WeFadeToGrayApp_001
//
//  Created by Vladimir Luciano on 1/26/13.
//  Copyright (c) 2013 Vladimir Luciano. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMLLoginParser : NSObject <NSXMLParserDelegate>

@property (strong, readonly) NSString *userName;
@property (strong, readonly) NSString *userId;
@property (strong, readonly) NSString *errorDescription;

-(id) loadXMLByURL:(NSString *)urlString andUser:(NSString *) user andPassword:(NSString *) pass;

@end
