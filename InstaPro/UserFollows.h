//
//  UserFollows.h
//  InstaPro
//
//  Created by Bradley Walker on 10/28/14.
//  Copyright (c) 2014 Ryan Siska. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import "User.h"

@interface UserFollows : PFObject <PFSubclassing>
@property PFUser *user;
@property PFUser *followee;

@end
