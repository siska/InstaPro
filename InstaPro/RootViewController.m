//
//  ViewController.m
//  InstaPro
//
//  Created by S on 10/27/14.
//  Copyright (c) 2014 Ryan Siska. All rights reserved.
//

#import "RootViewController.h"
#import <Parse/Parse.h>


@interface RootViewController ()
<<<<<<< HEAD
=======
@property (weak, nonatomic) IBOutlet UISegmentedControl *loginSignUpToggle;
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *verifyPassword;
@property (weak, nonatomic) IBOutlet UILabel *instructionLabel;
@property (weak, nonatomic) IBOutlet UITextField *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *passwordMatchingLabel;

>>>>>>> 8722ed5037822c13bfa0ae3b6d0833fa133ab3ef

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
<<<<<<< HEAD
=======
    self.verifyPassword.hidden = YES;  //Default toggled to Sign-In so this is hidden
    self.emailLabel.hidden = YES;
    self.passwordMatchingLabel.hidden = YES;
}

- (IBAction)loginSignUpSwitched:(id)sender
{
    if (self.loginSignUpToggle.selectedSegmentIndex == 0)
    {
        self.verifyPassword.hidden = YES;
        self.emailLabel.hidden = YES;
        self.passwordMatchingLabel.hidden = YES;
        self.instructionLabel.text = @"Please Login Below";
    }
    else
    {
        self.verifyPassword.hidden = NO;
        self.emailLabel.hidden = NO;
        self.passwordMatchingLabel.hidden = NO;
        self.passwordMatchingLabel.text = @"Ensure Passwords Match";
        self.instructionLabel.text = @"Please Sign Up Below";
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
            self.passwordMatchingLabel.text = @"Passwords do not match. Try Again";
            self.password.text = nil;
            self.verifyPassword.text = nil;
            [self.password becomeFirstResponder];

        }
        else
        {
            PFObject *user = [PFObject objectWithClassName:@"User"];
            user [@"username"] = self.username.text;
            user [@"password"] = self.password.text;
            user [@"email"] = self.emailLabel.text;

            [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (error)
                {
                    NSLog(@"Error: %@", [error userInfo]);
                }
            }];
        }
    }

>>>>>>> 8722ed5037822c13bfa0ae3b6d0833fa133ab3ef
}




@end
