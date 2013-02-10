//
//  XMLProjectsParser2.m
//  ParseFromServerModul
//
//  Created by Vladimir Luciano on 1/13/13.
//  Copyright (c) 2013 Vladimir Luciano. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMLProjectsParser.h"

@implementation XMLProjectsParser

@synthesize projects = _projects;
@synthesize dailies = _dailies;


NSMutableString	*currentNodeContent;
NSXMLParser	*parser;
Project	*currentProject;
DailySimple *currentDailySimple;



Boolean isDaily = NO;

-(id) loadXMLByURL:(NSString *)urlString AnduserName:(NSString *)user AndPassword:(NSString *)pass {
	
    NSLog(@"inside XMLProjectsParser.loadXMLByURL()");
    
    _projects = [[NSMutableArray alloc] init];
    
	NSURL *url	= [NSURL URLWithString:urlString];
    NSError *error = nil;
    NSHTTPURLResponse *response;
    
    // assemble the POST data
    
    NSString *post = [NSString stringWithFormat:@"username=%@&password=%@",user,pass];
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
    NSString *replyString = [[NSString alloc] initWithBytes:[serverReply bytes] length:[serverReply length] encoding: NSASCIIStringEncoding];
    NSLog(@"%@",replyString); // what ever i echo out of the php file - this is just to capture the whole output ...
    
	parser	= [[NSXMLParser alloc] initWithData:serverReply];
	parser.delegate = self;
	[parser parse];
	return self;
}

- (void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	//NSLog(@"inside parser()");
    currentNodeContent = (NSMutableString *) [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementname namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
	//NSLog(@"inside didStartElement():  %@", elementname);
    if ([elementname isEqualToString:@"project"]) {
		currentProject = [Project alloc];
        isDaily = NO;
	}
    if ([elementname isEqualToString:@"daily"]) {
        currentDailySimple = [DailySimple alloc];
    }
    
    if ([elementname isEqualToString:@"dailies"]) {
        _dailies = [[NSMutableArray alloc] init];
        isDaily = YES;
    }

    
}

- (void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementname namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    //NSLog(@"inside didEndElement():  %@", elementname);
    
    if ([elementname isEqualToString:@"name"]) {
        
        if (!isDaily) {
            currentProject.name = currentNodeContent;
        } else{
            currentDailySimple.name = currentNodeContent; 
        }
        
    }
    if ([elementname isEqualToString:@"ident"]) {
        
        if (!isDaily) {
            currentProject.ident = currentNodeContent;
        }else{
            currentDailySimple.ident = currentNodeContent;
        }        
    }

    
    if ([elementname isEqualToString:@"dop"]) {
        currentProject.dop = currentNodeContent;
    }
    
    if ([elementname isEqualToString:@"director"]) {
        currentProject.director = currentNodeContent;
    }
    
    if ([elementname isEqualToString:@"production"]) {
        currentProject.production = currentNodeContent;
    }
    
    
    if ([elementname isEqualToString:@"daily"]) {
        [_dailies addObject:currentDailySimple];
        currentDailySimple = nil;

    }

    if ([elementname isEqualToString:@"dailies"]) {
        isDaily = NO;
        currentProject.dailies = _dailies;
        _dailies = nil;
    }
    
	if ([elementname isEqualToString:@"project"]) {
        
		[_projects addObject:currentProject];
        
		currentProject = nil;
		currentNodeContent = nil;
	}
}

@end