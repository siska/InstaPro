//
//  Post.m
//  InstaPro
//
//  Created by Bradley Walker on 10/28/14.
//  Copyright (c) 2014 Ryan Siska. All rights reserved.
//

#import "Post.h"

@implementation Post
@dynamic caption;
@dynamic photoData;

+(void)load
{
    [self registerSubclass];
}

+(NSString *)parseClassName
{
    return @"Post";
}
@end
