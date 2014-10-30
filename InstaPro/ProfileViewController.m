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
@property NSArray *photos;
@property (strong, nonatomic) IBOutlet UIImageView *profileImageView;
@property (strong, nonatomic) IBOutlet UILabel *labelPosts;
//@property (strong, nonatomic) IBOutlet UILabel *labelFollowers;
//@property (strong, nonatomic) IBOutlet UILabel *labelFollowing;
@property (strong, nonatomic) IBOutlet UILabel *labelUsername;
@property UIImage *usersPhoto;
@property (strong, nonatomic) IBOutlet UICollectionView *imageCollectionView;
@property NSMutableArray *currentImages;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentImages = [NSMutableArray new];
    [self setUserProfileInformation];
    [self refreshDisplayWithUserPhotos];
}

-(void)setUserProfileInformation
{
    self.labelUsername.text = [PFUser currentUser].username;
}

-(void)refreshDisplayWithUserPhotos
{
    PFQuery *queryForPosts = [PFQuery queryWithClassName:@"Post"];
    [queryForPosts whereKey:@"user" equalTo:[PFUser currentUser]];
    [queryForPosts findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error.userInfo);
            self.photos = [NSArray array];
        }
        else {
            self.photos = objects;
            [self setPhotosForUser];
        }
    }];
}

-(void)setPhotosForUser
{
    for (PFObject *photo in self.photos)
    {
        PFFile *file = photo[@"photoData"];
        [file getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            if (!error) {
                UIImage *image = [UIImage imageWithData:data];
                [self.currentImages addObject:image];
                //self.usersPhotosImageView.image = image;
                // image can now be set on a UIImageView
            }
            [self.imageCollectionView reloadData];
            [self setPostNumberCount];
        }];
    }
}

-(void)setPostNumberCount
{
    self.labelPosts.text = [NSString stringWithFormat:@"%lu", (unsigned long)self.currentImages.count];
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

- (IBAction)onProfileImageTapped:(id)sender {
    NSLog(@"Tapped");

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"AlertView" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"GO" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              //  [action doSomething];
                                                          }];
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action) {
                                                       [alert dismissViewControllerAnimated:YES completion:nil];
                                                   }];

    [alert addAction:defaultAction];
    [alert addAction:cancel];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Your username here";

    }];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Your Email here";
    }];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Your Password here";
    }];
    
    [self presentViewController:alert animated:YES completion:nil];}

-(IBAction)unwindFollowUser:(UIStoryboardSegue *)sender
{

}

@end
