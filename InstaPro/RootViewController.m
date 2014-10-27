//
//  ViewController.m
//  InstaPro
//
//  Created by S on 10/27/14.
//  Copyright (c) 2014 Ryan Siska. All rights reserved.
//

#import "RootViewController.h"


@interface RootViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *loginSignUpToggle;
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *verifyPassword;
@property (weak, nonatomic) IBOutlet UILabel *instructionLabel;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.verifyPassword.hidden = YES;  //Default toggled to Sign-In so this is hidden
}

- (IBAction)loginSignUpSwitched:(id)sender
{
    if (self.loginSignUpToggle.selectedSegmentIndex == 0)
    {
        self.verifyPassword.hidden = YES;
        self.instructionLabel.text = @"Please Login Below";
    }
    else
    {
        self.verifyPassword.hidden = NO;
        self.instructionLabel.text = @"Please Sign-Up Below";
    }
}

- (IBAction)onLoginButtonPressed:(id)sender
{
    if (self.loginSignUpToggle.selectedSegmentIndex == 0)
    {
        //pull parse data for user
    }
    else //It will be on the Sign-up Screen so we can move right into those instructions
    {
        if (![self.password.text isEqualToString:self.verifyPassword.text])
        {
            self.verifyPassword.text = @"Passwords do not match. Try Again";
        }
        else
        {
            //enter new user into parse as an object
        }
    }

}


@end
