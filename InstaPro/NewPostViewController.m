//
//  NewPostViewController.m
//  InstaPro
//
//  Created by Bradley Walker on 10/27/14.
//  Copyright (c) 2014 Ryan Siska. All rights reserved.
//

#import "NewPostViewController.h"
#import <Parse/Parse.h>

@interface NewPostViewController () <UIImagePickerControllerDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIButton *addPhotoFromCameraRollButton;
@property (strong, nonatomic) IBOutlet UITextField *captionTextField;
@property UIImagePickerController *picker;
@end

@implementation NewPostViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.picker = [[UIImagePickerController alloc] init];
    self.picker.delegate = self;
}

#pragma mark - Manage Photo Selection
- (IBAction)onAddPhotoFromCameraRollButtonPressed:(id)sender
{
    self.picker.allowsEditing = YES;
    self.picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    self.picker.modalPresentationStyle = UIModalPresentationCurrentContext;
    [self presentViewController:self.picker animated:YES completion:NULL];
}

- (IBAction)onAddPhotoFromCameraButtonPressed:(id)sender
{
    self.picker.allowsEditing = YES;
    self.picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    self.picker.modalPresentationStyle = UIModalPresentationCurrentContext;
    [self presentViewController:self.picker animated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *selectedImage = info[UIImagePickerControllerEditedImage];
    self.imageView.image = selectedImage;
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, nil, nil, nil);
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - Save selected photo to Parse
- (IBAction)onSaveButtonPressed:(id)sender
{
    PFObject *newPost = [PFObject objectWithClassName:@"Post"];

    newPost[@"photoData"] = [PFFile fileWithData:UIImagePNGRepresentation(self.imageView.image)];
    newPost[@"caption"] = self.captionTextField.text;
    newPost[@"user"] = [PFUser currentUser];

    [newPost saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (error)
        {
            NSLog(@"Error: %@", [error userInfo]);
        }
    }];

    [self.captionTextField resignFirstResponder];
    
}

@end
