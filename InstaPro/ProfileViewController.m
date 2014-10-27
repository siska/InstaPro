//
//  ProfileViewController.m
//  InstaPro
//
//  Created by S on 10/27/14.
//  Copyright (c) 2014 Ryan Siska. All rights reserved.
//

#import "ProfileViewController.h"
#import <Parse/Parse.h>

@interface ProfileViewController ()
@property NSArray *user;
@property (strong, nonatomic) IBOutlet UIImageView *profileImageView;
@property (strong, nonatomic) IBOutlet UILabel *labelPosts;
@property (strong, nonatomic) IBOutlet UILabel *labelFollowers;
@property (strong, nonatomic) IBOutlet UILabel *labelFollowing;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self refreshDisplayWithUserInfo];
}

-(void)refreshDisplayWithUserInfo
{
    PFQuery *query = [PFQuery queryWithClassName:@"User"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error.userInfo);
            self.user = [NSArray array]; //5 - want to set to null so app doesn't crash, app expects some array back after this method
        }
        else {
            self.user = objects;
            [self setUserProfileInformation];
        }
    }];
}

-(void)setUserProfileInformation
{

}


@end
