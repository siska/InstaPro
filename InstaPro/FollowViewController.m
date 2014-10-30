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
@property NSArray *userFollowed;
@property NSArray *followedUsers;
@end

@implementation FollowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.userFollowed = [[NSArray alloc] init];
    self.followedUsers = [[NSArray alloc] init];

    [self checkFollowees:[PFUser currentUser]];
    [self refreshDisplay];
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

    if (self.followedUsers.count != 0)
    {
        for (UserFollows *userFollowRecord in self.followedUsers)
        {
            if ([userFollowRecord.followee.objectId isEqualToString:followUser.objectId])
            {
                cell.followIcon.image = [UIImage imageNamed:@"unfollowUser"];
            }
            else
            {
                cell.followIcon.image = [UIImage imageNamed:@"followUser"];
            }
        }
    }
    else
    {
        cell.followIcon.image = [UIImage imageNamed:@"followUser"];
    }
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PFUser *selectedUser = [self.allUsers objectAtIndex:[tableView indexPathForSelectedRow].row];
    FollowerTableViewCell *cell = [tableView cellForRowAtIndexPath:[tableView indexPathForSelectedRow]];
    [self checkFollowRelationship:selectedUser];
}

-(void)followUser:(PFUser *)followee
{
    NSLog(@"User followed");
    UserFollows *userFollow = [UserFollows object];
    userFollow.user = [PFUser currentUser];
    userFollow.followee = followee;
    [userFollow saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        [self checkFollowees:[PFUser currentUser]];
    }];
}

-(void)unfollowUser
{
    NSLog(@"User unfollowed");
    UserFollows *userFollow = self.userFollowed.firstObject;
    [userFollow deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        [self checkFollowees:[PFUser currentUser]];
    }];
}

- (void) checkFollowees:(PFUser *)selectedUser
{
    PFQuery *followersQuery = [PFQuery queryWithClassName:@"UserFollows"];
    [followersQuery whereKey:@"user" equalTo:[PFUser currentUser]];

    [followersQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
     {
         if (error)
         {
             NSLog(@"%@", error);
         }
         else
         {
             self.followedUsers = objects;
             [self.tableView reloadData];
         }
     }];
}

- (void) checkFollowRelationship:(PFUser *)selectedUser
{
    PFQuery *isFollowedQuery = [PFQuery queryWithClassName:@"UserFollows"];
    [isFollowedQuery whereKey:@"followee" equalTo:selectedUser];
    [isFollowedQuery whereKey:@"user" equalTo:[PFUser currentUser]];

    [isFollowedQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
     {
     if (error)
     {
         NSLog(@"%@", error);
     }
     else
     {
         self.userFollowed = objects;

         if (self.userFollowed.count == 0)
         {
             [self followUser:selectedUser];
         }
         else
         {
             [self unfollowUser];
         }
     }
     }];
}

- (void) refreshDisplay
{
    PFQuery *allUsers = [PFQuery queryWithClassName:[PFUser parseClassName]];
    [allUsers whereKey:@"objectId" notEqualTo:[PFUser currentUser].objectId];
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
