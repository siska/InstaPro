//
//  NewsfeedViewController.m
//  InstaPro
//
//  Created by Wade Sellers on 10/28/14.
//  Copyright (c) 2014 Ryan Siska. All rights reserved.
//

#import "NewsfeedViewController.h"
#import <Parse/Parse.h>

@interface NewsfeedViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *NewsfeedCollectionView;
@property (weak, nonatomic) IBOutlet UISearchBar *newsfeedSearchBar;

@end

@implementation NewsfeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (IBAction)newsfeedLogoutButtonPressed:(id)sender {
}




@end
