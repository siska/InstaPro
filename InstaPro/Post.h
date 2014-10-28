//
//  Post.h
//  InstaPro
//
//  Created by Bradley Walker on 10/28/14.
//  Copyright (c) 2014 Ryan Siska. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import "User.h"

@interface Post : PFObject <PFSubclassing>
@property NSString *caption;
@property PFFile *photoData;
@property User *user;

@end
