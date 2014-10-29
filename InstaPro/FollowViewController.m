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
@end

@implementation FollowViewController

- (void)viewDidLoad {
    [super viewDidLoad];

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
    cell.followIcon.image = [UIImage imageNamed:@"followUser"];

    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FollowerTableViewCell *cell = [tableView cellForRowAtIndexPath:[tableView indexPathForSelectedRow]];
    cell.followIcon.image = [UIImage imageNamed:@"unfollowUser"];
//    [self.tableView reloadData];
}

-(void)followUser
{

}

-(void)unfollowUser
{

}

- (void) refreshDisplay
{
            PFQuery *followingQuery = [PFQuery queryWithClassName:[PFUser parseClassName]];
    [followingQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
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
