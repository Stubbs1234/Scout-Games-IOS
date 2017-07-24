//
//  Login.m
//  Scout Games
//
//  Created by Alex Stubbs on 18/03/2015.
//  Copyright (c) 2015 Alex Stubbs. All rights reserved.
//

#import "Login.h"

@interface Login ()

@end

@implementation Login


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.logLabel.hidden = YES;
    //(Left and right, up and down, width, height)
    self.group.hidden = YES;
    
    self.view.backgroundColor = [UIColor colorWithRed:238/255.0f green:238/255.0f blue:238/255.0f alpha:1];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser) {
        FirstViewController *FirstViewController =
        [self.storyboard instantiateViewControllerWithIdentifier:@"HOME"];
        [self presentModalViewController:FirstViewController animated:YES];
    } else {
        NSLog(@"windows will not load");
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)loginButton:(id)sender {
    self.logLabel.hidden = NO;
    self.loginUsernameField.hidden = YES;
    self.loginPasswordField.hidden = YES;
    self.logButton.hidden = YES;
    self.forget.hidden = YES;
    self.needAccount.hidden = YES;
    [_loginUsernameField resignFirstResponder];
    [_loginPasswordField resignFirstResponder];
    [PFUser logInWithUsernameInBackground:_loginUsernameField.text password:_loginPasswordField.text block:^(PFUser *user, NSError *error) {
        if (!error) {
            NSLog(@"Login user!");
            _loginPasswordField.text = nil;
            _loginUsernameField.text = nil;
            _usernameField.text = nil;
            _passwordField.text = nil;
            _reEnterPasswordField.text = nil;
            _emailField.text = nil;
            [self performSegueWithIdentifier:@"login" sender:self];
            }
        if (error) {
            self.logLabel.hidden = YES;
            self.loginUsernameField.hidden = NO;
            self.loginPasswordField.hidden = NO;
            self.logButton.hidden = NO;
            self.forget.hidden = NO;
            self.needAccount.hidden = NO;
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ooops!" message:@"Sorry we had a problem logging you in" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }];
}

- (IBAction)forget:(id)sender {
    [self getEmail];
}

- (void)getEmail {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Email Address" message:@"Please enter your email address for your account:" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex != [alertView cancelButtonIndex]) {
        UITextField *emailTextField = [alertView textFieldAtIndex:0];
        [self sendEmail:emailTextField.text];
    }
}

- (void)sendEmail:(NSString *)email{
    [PFUser requestPasswordResetForEmailInBackground:email];
}

-(IBAction)textFieldReturn:(id)sender
{
    [sender resignFirstResponder];}


@end
