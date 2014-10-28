//
//  NewPostViewController.m
//  InstaPro
//
//  Created by Bradley Walker on 10/27/14.
//  Copyright (c) 2014 Ryan Siska. All rights reserved.
//

#import "NewPostViewController.h"
#import <Parse/Parse.h>

@interface NewPostViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIButton *addPhotoFromCameraRollButton;
@property (strong, nonatomic) IBOutlet UITextField *captionTextField;

@end

@implementation NewPostViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    
}

#pragma mark - Manage Photo Selection
- (IBAction)onAddPhotoFromCameraRollButtonPressed:(id)sender
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:NULL];
}

- (IBAction)onAddPhotoFromCameraButtonPressed:(id)sender
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *selectedImage = info[UIImagePickerControllerEditedImage];
    self.imageView.image = selectedImage;
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - Save selected photo to Parse
- (IBAction)onSaveButtonPressed:(id)sender
{
    PFObject *newPost = [PFObject objectWithClassName:@"Post"];

    newPost[@"photoData"] = [PFFile fileWithData:UIImagePNGRepresentation(self.imageView.image)];
    newPost[@"caption"] = self.captionTextField.text;

    [newPost saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (error)
        {
            NSLog(@"Error: %@", [error userInfo]);
        }
    }];
}

@end
