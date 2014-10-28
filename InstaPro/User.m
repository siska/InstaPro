//
//  User.m
//  InstaPro
//
//  Created by Bradley Walker on 10/28/14.
//  Copyright (c) 2014 Ryan Siska. All rights reserved.
//

#import "User.h"

@implementation User
@dynamic email;
@dynamic password;
@dynamic username;

+(void)load
{
    [self registerSubclass];
}

+(NSString *)parseClassName
{
    return @"User";
}
@end
