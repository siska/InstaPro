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


//adam said that when we post photos we can also pass the current user into the parse table so it has that attachment too.  Not sure if we want or need it, but he just said it.