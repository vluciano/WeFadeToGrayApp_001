//
//  Dailies.h
//  ParseFromServerModul
//
//  Created by Vladimir Luciano on 1/19/13.
//  Copyright (c) 2013 Vladimir Luciano. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Daily : NSObject

@property (strong, nonatomic) NSString *ident;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *created;

//Info
@property (strong, nonatomic) NSString *director;
@property (strong, nonatomic) NSString *dop;
@property (strong, nonatomic) NSString *production;
@property (strong, nonatomic) NSString *comment;


//sequence
@property (strong, nonatomic) NSString *sec_name;
@property (strong, nonatomic) NSString *sec_duration;
@property (strong, nonatomic) NSString *sec_clips;


@end
