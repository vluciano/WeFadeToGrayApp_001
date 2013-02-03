//
//  Projects2.h
//  ParseFromServerModul
//
//  Created by Vladimir Luciano on 1/13/13.
//  Copyright (c) 2013 Vladimir Luciano. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Project : NSObject

@property (strong, nonatomic)NSString *name;
@property (strong, nonatomic)NSString *ident;
@property (strong, nonatomic)NSString *director;
@property (strong, nonatomic)NSString *dop;
@property (strong, nonatomic)NSString *production;

@property (strong, nonatomic)NSMutableArray *dailies;

@end
