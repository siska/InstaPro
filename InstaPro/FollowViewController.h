//
//  FollowViewController.h
//  InstaPro
//
//  Created by Bradley Walker on 10/29/14.
//  Copyright (c) 2014 Ryan Siska. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface FollowViewController : UIViewController
@property BOOL *viewingFollowers;
@property PFUser *user;
@end
