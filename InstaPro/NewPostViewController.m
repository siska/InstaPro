//
//  NewPostViewController.m
//  InstaPro
//
//  Created by Bradley Walker on 10/27/14.
//  Copyright (c) 2014 Ryan Siska. All rights reserved.
//

#import "NewPostViewController.h"

@interface NewPostViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIButton *addPhotoButton;
@property (strong, nonatomic) IBOutlet UITextField *captionTextField;

@end

@implementation NewPostViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    
}

#pragma mark - Manage Photo Selection
- (IBAction)onAddPhotoButtonPressed:(id)sender
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *selectedImage = info[UIImagePickerControllerEditedImage];
    self.imageView.image = selectedImage;
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)onSaveButtonPressed:(id)sender
{

}

@end
