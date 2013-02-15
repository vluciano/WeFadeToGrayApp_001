//
//  Clip.h
//  WeFadeToGrayApp_001
//
//  Created by Vladimir Luciano on 2/13/13.
//  Copyright (c) 2013 Vladimir Luciano. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Clip : NSObject

@property (strong, nonatomic) NSString *clipName;
@property (strong, nonatomic) NSString *start;
@property (strong, nonatomic) NSString *length;
@property (strong, nonatomic) NSString *thumbnail_path;
@property (strong, nonatomic) NSString *thumbnail_size_width;
@property (strong, nonatomic) NSString *thumbnail_size_height;
@property (strong, nonatomic) NSString *trackingclip;



@end
