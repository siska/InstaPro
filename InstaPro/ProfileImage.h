//
//  ProfileImage.h
//  InstaPro
//
//  Created by S on 10/30/14.
//  Copyright (c) 2014 Ryan Siska. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import "User.h"

@interface ProfileImage : PFObject <PFSubclassing>
@property PFFile *photoData;
@property PFUser *user;

@end