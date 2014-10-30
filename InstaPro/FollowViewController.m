//
//  FollowViewController.m
//  InstaPro
//
//  Created by Bradley Walker on 10/29/14.
//  Copyright (c) 2014 Ryan Siska. All rights reserved.
//

#import "FollowViewController.h"
#import "UserFollows.h"
#import "FollowerTableViewCell.h"

@interface FollowViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property NSArray *allUsers;
@property NSArray *followedUsers;
@end

@implementation FollowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self refreshDisplay];

    self.followedUsers = [[NSArray alloc] init];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.allUsers.count;
}

-(FollowerTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FollowerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FollowCell"];
    PFUser *followUser = [self.allUsers objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:17];
    cell.textLabel.text = followUser.username;
    cell.followIcon.image = [UIImage imageNamed:@"followUser"];

    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PFUser *selectedUser = [self.allUsers objectAtIndex:[tableView indexPathForSelectedRow].row];
    FollowerTableViewCell *cell = [tableView cellForRowAtIndexPath:[tableView indexPathForSelectedRow]];
    cell.followIcon.image = [UIImage imageNamed:@"unfollowUser"];

    [self checkFollowers:selectedUser];
}

-(void)followUser:(PFUser *)followee
{
    NSLog(@"User followed");
    UserFollows *userFollow = [UserFollows object];
    userFollow.user = [PFUser currentUser];
    userFollow.followee = followee;
    [userFollow saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
    }];
}

-(void)unfollowUser
{
    NSLog(@"User unfollowed");
}

- (void) checkFollowers:(PFUser *)selectedUser
{
    PFQuery *followingQuery = [PFQuery queryWithClassName:@"UserFollows"];
    [followingQuery whereKey:@"followee" equalTo:selectedUser];
    [followingQuery whereKey:@"user" equalTo:[PFUser currentUser]];

    [followingQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
     {
     if (error)
     {
         NSLog(@"%@", error);
     }
     else
     {
         self.followedUsers = objects;

         if (self.followedUsers.count == 0)
         {
             [self followUser:selectedUser];
         }
         else //create unfollow logic
             
         {
             [self unfollowUser];
         }
     }
     }];
}

- (void) refreshDisplay
{
    PFQuery *allUsers = [PFQuery queryWithClassName:[PFUser parseClassName]];
    [allUsers findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
     {
         if (error)
         {
             NSLog(@"%@", error);
         }
         else
         {
             self.allUsers = objects;
             [self.tableView reloadData];
         }
     }];
}

@end
