//
//  NewsfeedViewController.m
//  InstaPro
//
//  Created by Wade Sellers on 10/28/14.
//  Copyright (c) 2014 Ryan Siska. All rights reserved.
//

#import "NewsfeedViewController.h"
#import <Parse/Parse.h>
#import "NewsfeedCollectionViewCell.h"

@interface NewsfeedViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *NewsfeedCollectionView;
@property (weak, nonatomic) IBOutlet UISearchBar *newsfeedSearchBar;
@property NSMutableArray *imageArray;
@property NSArray *photosFromPostQuery;


@end

@implementation NewsfeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageArray = [NSMutableArray new];
    [self refreshNewsfeedWithPostPhotos];

    NSLog(@"Current User %@", [PFUser currentUser]);

}

- (IBAction)newsfeedLogoutButtonPressed:(id)sender
{
    //Figure out how to logout and unwind back to the rootVC where the Parse login is.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NewsfeedCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"newsfeedCell" forIndexPath:indexPath];
    UIImage *images = [self.imageArray objectAtIndex:indexPath.row];
    cell.NewsfeedImageView.image = images;
    return cell;
}

-(void)refreshNewsfeedWithPostPhotos
{
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error.userInfo);
            self.photosFromPostQuery = [NSArray array];
        }
        else {
            self.photosFromPostQuery = objects;
            [self setPhotosForUser];
        }
    }];
}

-(void)setPhotosForUser
{
    PFObject *photo = self.photosFromPostQuery.firstObject;
    PFFile *file = photo[@"photoData"];


    //PFFile *file = [PFObject objectWithClassName:@"photoData"];
    [file getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if (!error) {
            UIImage *image = [UIImage imageWithData:data];
            [self.imageArray addObject:image];
            [self.NewsfeedCollectionView reloadData];
            //self.usersPhotosImageView.image = image;
            // image can now be set on a UIImageView
        }
    }];
}

@end
