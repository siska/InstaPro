//
//  ProfileViewController.m
//  InstaPro
//
//  Created by S on 10/27/14.
//  Copyright (c) 2014 Ryan Siska. All rights reserved.
//

#import "ProfileViewController.h"
#import <Parse/Parse.h>
#import "ProfileCollectionViewCell.h"

@interface ProfileViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property NSArray *user;
@property NSArray *photo;
@property (strong, nonatomic) IBOutlet UIImageView *profileImageView;
@property (strong, nonatomic) IBOutlet UILabel *labelPosts;
@property (strong, nonatomic) IBOutlet UILabel *labelFollowers;
@property (strong, nonatomic) IBOutlet UILabel *labelFollowing;
@property (strong, nonatomic) IBOutlet UILabel *labelUsername;
@property UIImage *usersPhoto;
@property (strong, nonatomic) IBOutlet UICollectionView *imageCollectionView;
@property NSMutableArray *currentImages;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentImages = [NSMutableArray new];
    [self refreshDisplayWithUserInfo];
    [self refreshDisplayWithUserPhotos];
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
    PFObject *person = self.user.firstObject; //will have to change to say I want a specific user - the main user
    //self.profileImageView = person[@"profilePhoto"]; - will likely have to actually convert this from data
    self.labelUsername.text = person[@"username"];
    // no array yet - self.labelPosts.text = person[@"postArray"].count;
    //will use this space to set
}

-(void)refreshDisplayWithUserPhotos
{
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error.userInfo);
            self.photo = [NSArray array]; //5 - want to set to null so app doesn't crash, app expects some array back after this method
        }
        else {
            self.photo = objects;
            [self setPhotosForUser];
        }
    }];
}

-(void)setPhotosForUser
{
    PFObject *photo = self.photo.firstObject;
    PFFile *file = photo[@"photoData"];


    //PFFile *file = [PFObject objectWithClassName:@"photoData"];
    [file getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if (!error) {
            UIImage *image = [UIImage imageWithData:data];
            [self.currentImages addObject:image];
            [self.imageCollectionView reloadData];
            //self.usersPhotosImageView.image = image;
            // image can now be set on a UIImageView
        }
    }];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ProfileCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UserImageCell" forIndexPath:indexPath];
    UIImage *images = [self.currentImages objectAtIndex:indexPath.row];

    cell.imageView.image = images;
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.currentImages.count;
}


@end