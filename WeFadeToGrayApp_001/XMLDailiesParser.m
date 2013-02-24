//
//  XMLDailiesParser.m
//  ParseFromServerModul
//
//  Created by Vladimir Luciano on 1/19/13.
//  Copyright (c) 2013 Vladimir Luciano. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMLDailiesParser.h"


@implementation XMLDailiesParser

@synthesize dailies = _dailies;
@synthesize clips = _clips;

NSMutableString	*currentNodeContent;
NSXMLParser	*parser;
Daily	*currentDaily;
Boolean isSequence = NO;
Boolean isClip = NO;

Clip *currentClip;


-(id) loadXMLByURL:(NSString *)urlString AndProjectIdent:(NSString *) ident AndUserName:(NSString *)user AndPassword:(NSString *)pass {
    
	//NSLog(@"inside XMLDailiesParser.loadXMLByURL()");
    
    _dailies = [[NSMutableArray alloc] init];
	NSURL *url	= [NSURL URLWithString:urlString];
    NSError *error = nil;
    NSHTTPURLResponse *response;
    
    // assemble the POST data
    
    NSString *post = [NSString stringWithFormat:@"username=%@&password=%@&project=%@",user,pass,ident];
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

- (void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	//NSLog(@"inside parser()");
    currentNodeContent = (NSMutableString *) [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementname namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
	//NSLog(@"inside didStartElement():  %@", elementname);
    if ([elementname isEqualToString:@"daily"]) {
		currentDaily = [Daily alloc];
        isSequence = NO;
        isClip = NO;
	}
    if ([elementname isEqualToString:@"sequence"]) {
        isSequence = YES;
        isClip = NO;
    }

    if ([elementname isEqualToString:@"clip"]) {
        currentClip = [Clip alloc];
        isClip = YES;
        isSequence = NO;
    }
    
    if ([elementname isEqualToString:@"clips"]) {
        _clips = [[NSMutableArray alloc] init];
        
    }
    
    
    
    
}

- (void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementname namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    //NSLog(@"inside didEndElement():  %@", elementname);
    
    if ([elementname isEqualToString:@"name"]) {
        if (!isSequence && !isClip) {
            currentDaily.name = currentNodeContent;
        }else if (isSequence && !isClip) {
            currentDaily.sec_name = currentNodeContent;
        }else if (!isSequence && isClip){
            currentClip.clipName = currentNodeContent;
        }
    }
    
    if ([elementname isEqualToString:@"ident"]) {
        currentDaily.ident = currentNodeContent;
    }
    
    if ([elementname isEqualToString:@"created"]) {
        currentDaily.created = currentNodeContent;
    }
    
    //----------------------------------------------------
    
    if ([elementname isEqualToString:@"dop"]) {
        currentDaily.dop = currentNodeContent;
    }
    
    if ([elementname isEqualToString:@"director"]) {
        currentDaily.director = currentNodeContent;
    }
    
    if ([elementname isEqualToString:@"production"]) {
        currentDaily.production = currentNodeContent;
    }
    
    if ([elementname isEqualToString:@"comment"]) {
        currentDaily.comment = currentNodeContent;
    }
    
    
    if ([elementname isEqualToString:@"duration"]) {
        currentDaily.sec_duration = currentNodeContent;
    }
    
    if ([elementname isEqualToString:@"url"]) {
        currentDaily.url = currentNodeContent;
    }
    
    
    if (isSequence && !isClip && [elementname isEqualToString:@"clips"]) {
        currentDaily.sec_clips = currentNodeContent;
    }
    
    //Clip
    if ([elementname isEqualToString:@"start"]) {
        currentClip.start = currentNodeContent;
    }
    if ([elementname isEqualToString:@"length"]) {
        currentClip.length = currentNodeContent;
    }
    if ([elementname isEqualToString:@"large"]) {
        currentClip.thumbnail_path = currentNodeContent;
    }
    if ([elementname isEqualToString:@"trackingclip"]) {
        currentClip.trackingclip = currentNodeContent;
    }
    
    
    if ([elementname isEqualToString:@"clip"]) {
        [_clips addObject:currentClip];
        currentClip = nil;
    }
    
    if (isClip && [elementname isEqualToString:@"clips"]) {
        isClip = NO;
        currentDaily.clips = _clips;
        _clips = nil;
    }
    
	if ([elementname isEqualToString:@"daily"]) {
		[self.dailies addObject:currentDaily];
		currentDaily = nil;
		currentNodeContent = nil;
	}
}

@end
