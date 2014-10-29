//
//  UserFollows.m
//  InstaPro
//
//  Created by Bradley Walker on 10/28/14.
//  Copyright (c) 2014 Ryan Siska. All rights reserved.
//

#import "UserFollows.h"

@implementation UserFollows
@dynamic user;
@dynamic followee;

+(void)load
{
    [self registerSubclass];
}

+(NSString *)parseClassName
{
    return @"UserFollows";
}
@end
