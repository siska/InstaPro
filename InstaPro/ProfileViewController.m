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

@interface ProfileViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UIImagePickerControllerDelegate>
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
@property UIImagePickerController *picker;
@property NSArray *profilePhotos;


@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.picker = [[UIImagePickerController alloc] init];
    self.picker.delegate = self;
    self.currentImages = [NSMutableArray new];
    [self setUserProfileInformation];
    [self queryUserProfileImage];
    [self refreshDisplayWithUserPhotos];

}

-(void)setUserProfileInformation
{
    self.labelUsername.text = [PFUser currentUser].username;
}

-(void)queryUserProfileImage
{
    PFQuery *queryForProfileImage = [PFQuery queryWithClassName:@"ProfileImage"];
    [queryForProfileImage whereKey:@"user" equalTo:[PFUser currentUser]];
    [queryForProfileImage findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error.userInfo);
            self.profilePhotos = [NSArray array];
        }
        else
        {
            self.profilePhotos = objects;
            [self setProfileForUser];
        }
    }];
}

-(void)setProfileForUser
{
    if (self.profilePhotos.count == 0)
    {
        NSLog(@"The profile image should stay");
    }
    else
    {
        for (PFObject *profilePhoto in self.profilePhotos)
        {
            PFFile *file = profilePhoto[@"photoData"];
            [file getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                if (!error) {
                    UIImage *image = [UIImage imageWithData:data];
                    self.profileImageView.image = image;
                }
            }];
        }
    }
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
    [self onAddPhotoFromCameraButtonPressed:sender];

}

#pragma mark UIImagePicker Methods & Delegates

- (IBAction)onAddPhotoFromCameraButtonPressed:(id)sender
{
    self.picker.allowsEditing = YES;
    self.picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    self.picker.modalPresentationStyle = UIModalPresentationCurrentContext;
    [self presentViewController:self.picker animated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *selectedImage = info[UIImagePickerControllerEditedImage];
    self.profileImageView.image = selectedImage;
    UIImageWriteToSavedPhotosAlbum(self.profileImageView.image, nil, nil, nil);
    [picker dismissViewControllerAnimated:YES completion:NULL];
    [self saveProfileImageToParse];
}

-(void)saveProfileImageToParse
{
    PFObject *newProfileImage = [PFObject objectWithClassName:@"ProfileImage"];

    newProfileImage[@"photoData"] = [PFFile fileWithData:UIImagePNGRepresentation(self.profileImageView.image)];
    newProfileImage[@"user"] = [PFUser currentUser];

    [newProfileImage saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (error)
        {
            NSLog(@"Error: %@", [error userInfo]);
        }
    }];
}


#pragma mark Unwind Segue

-(IBAction)unwindFollowUser:(UIStoryboardSegue *)sender
{

}

@end
