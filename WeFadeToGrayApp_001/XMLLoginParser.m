//
//  XMLLoginParser.m
//  WeFadeToGrayApp_001
//
//  Created by Vladimir Luciano on 1/26/13.
//  Copyright (c) 2013 Vladimir Luciano. All rights reserved.
//

#import "XMLLoginParser.h"

@implementation XMLLoginParser

@synthesize userName = _userName;
@synthesize userId = _userId;
@synthesize errorDescription = _errorDescription;

NSXMLParser	*parser;
NSMutableString	*currentNodeContent;
bool isError = NO;

-(id) loadXMLByURL:(NSString *)urlString andUser:(NSString *) name andPassword:(NSString *) password {;
    
	NSLog(@"inside XMLLoginparser - loadXMLByURL()");
    
    _userName = [[NSString alloc] init];
    _userId = [[NSString alloc] init];
    
    
	NSURL *url	= [NSURL URLWithString:urlString];
    NSError *error = nil;
    NSHTTPURLResponse *response;
    
    // assemble the POST data
    
    NSString *post = [NSString stringWithFormat:@"username=%@&password=%@",name,password];
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    // send it
    
    NSData *serverReply = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    //NSString *replyString = [[NSString alloc] initWithBytes:[serverReply bytes] length:[serverReply length] encoding: NSASCIIStringEncoding];
    //NSLog(@"%@",replyString); // what ever i echo out of the php file - this is just to capture the whole output ...
    
	parser	= [[NSXMLParser alloc] initWithData:serverReply];
	parser.delegate = self;
	[parser parse];
    
	return self;
}

- (void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	//NSLog(@"inside parser()");
    currentNodeContent = (NSMutableString *) [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementname namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
	//NSLog(@"inside didStartElement():  %@", elementname);
    if ([elementname isEqualToString:@"error"]) {
        isError = YES;
    } 
    
}

- (void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementname namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    //NSLog(@"inside didEndElement():  %@", elementname);
    if ([elementname isEqualToString:@"userid"]) {
        _userId = currentNodeContent;
    }
    if ([elementname isEqualToString:@"username"]) {
        _userName = currentNodeContent;
    }
    
    if (isError) {
        if ([elementname isEqualToString:@"description"]) {
            _errorDescription = currentNodeContent;
        }
    }
}

@end
