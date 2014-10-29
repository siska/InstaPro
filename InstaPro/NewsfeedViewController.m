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


@end

@implementation NewsfeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];

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



@end
