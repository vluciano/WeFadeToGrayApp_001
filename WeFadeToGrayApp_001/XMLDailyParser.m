//
//  XMLDailyParser.m
//  WeFadeToGrayApp_001
//
//  Created by Vladimir Luciano on 2/24/13.
//  Copyright (c) 2013 Vladimir Luciano. All rights reserved.
//

#import "XMLDailyParser.h"

@implementation XMLDailyParser


@synthesize daily = _daily;
@synthesize clips = _clips;

NSMutableString	*currentNodeContent;
NSXMLParser	*parser;
Daily	*currentDaily;
Boolean isSequenceX = NO;
Boolean isClipX = NO;

Clip *currentClip;


-(id) loadXMLByURL:(NSString *)urlString AndDailyIdent:(NSString *) ident AndUserName:(NSString *)user AndPassword:(NSString *)pass {
    
	NSLog(@"inside XMLDailiesParser.loadXMLByURL()");
    
	NSURL *url	= [NSURL URLWithString:urlString];
    NSError *error = nil;
    NSHTTPURLResponse *response;
    
    // assemble the POST data
    
    NSString *post = [NSString stringWithFormat:@"username=%@&password=%@&daily=%@",user,pass,ident];
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
        isSequenceX = NO;
        isClipX = NO;
	}
    if ([elementname isEqualToString:@"sequence"]) {
        isSequenceX = YES;
        isClipX = NO;
    }
    
    if ([elementname isEqualToString:@"clip"]) {
        currentClip = [Clip alloc];
        isClipX = YES;
        isSequenceX = NO;
    }
    
    if ([elementname isEqualToString:@"clips"]) {
        _clips = [[NSMutableArray alloc] init];
        
    }
    
    
    
    
}

- (void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementname namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    //NSLog(@"inside didEndElement():  %@", elementname);
    
    if ([elementname isEqualToString:@"name"]) {
        if (!isSequenceX && !isClipX) {
            currentDaily.name = currentNodeContent;
        }else if (isSequenceX && !isClipX) {
            currentDaily.sec_name = currentNodeContent;
        }else if (!isSequenceX && isClipX){
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
    
    
    if (isSequenceX && !isClipX && [elementname isEqualToString:@"clips"]) {
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
        currentClip.thumbnail_path_large = currentNodeContent;
    }
    if ([elementname isEqualToString:@"small"]) {
        currentClip.thumbnail_path_small = currentNodeContent;
    }
    if ([elementname isEqualToString:@"medium"]) {
        currentClip.thumbnail_path_medium = currentNodeContent;
    }
    
    
    if ([elementname isEqualToString:@"trackingclip"]) {
        currentClip.trackingclip = currentNodeContent;
    }
    
    
    if ([elementname isEqualToString:@"clip"]) {
        [_clips addObject:currentClip];
        currentClip = nil;
    }
    
    if (isClipX && [elementname isEqualToString:@"clips"]) {
        isClipX = NO;
        currentDaily.clips = _clips;
        _clips = nil;
    }
    
	if ([elementname isEqualToString:@"daily"]) {
		_daily = currentDaily;
		currentDaily = nil;
		currentNodeContent = nil;
	}
}

@end
