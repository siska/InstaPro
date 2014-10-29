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
@property NSArray *followUsers;
@end

@implementation FollowViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self refreshDisplay];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.followUsers.count;
}

-(FollowerTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FollowerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FollowCell"];
    PFUser *followUser = [self.followUsers objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:17];
    cell.textLabel.text = followUser.username;
    cell.followIcon.image = [UIImage imageNamed:@"followUser"];

//    PFQuery *followQuery = [PFUser query];
//    [followQuery whereKey:@"owner" equalTo:person];
//    [followQuery countObjectsInBackgroundWithBlock:^(int number, NSError *error) {
//        cell.detailTextLabel.text = @(number).stringValue;
//    }];

    return cell;
}

- (void) refreshDisplay
{
//    if (self.viewingFollowers)
//    {
            PFQuery *followingQuery = [PFQuery queryWithClassName:[PFUser parseClassName]];
    [followingQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
     {
         if (error)
         {
             NSLog(@"%@", error);
         }
         else
         {
             self.followUsers = objects;
             [self.tableView reloadData];
         }
     }];
//    }
//    else
//    {
//        PFQuery *followedQuery = [PFQuery queryWithClassName:@"UserFollows"];
//        [followedQuery whereKey:@"followee" equalTo:[PFUser currentUser]];
//        [followedQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//            if (error)
//            {
//                NSLog(@"%@", error);
//            }
//            else
//            {
//                self.followUsers = objects;
//                [self.tableView reloadData];
//            }
//        }];
//    }
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{

}

@end
