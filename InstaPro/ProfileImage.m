//
//  ProfileImage.m
//  InstaPro
//
//  Created by S on 10/30/14.
//  Copyright (c) 2014 Ryan Siska. All rights reserved.
//

#import "ProfileImage.h"

@implementation ProfileImage
@dynamic photoData;
@dynamic user;

+(void)load
{
    [self registerSubclass];
}

+(NSString *)parseClassName
{
    return @"ProfileImage";
}

@end


