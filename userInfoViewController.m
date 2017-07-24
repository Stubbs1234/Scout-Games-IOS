//
//  userInfoTableViewController.m
//  Scout Games
//
//  Created by Alex Stubbs7 on 23/05/2015.
//  Copyright (c) 2015 Alex Stubbs. All rights reserved.
//

#import "userInfoViewController.h"

@interface userInfoViewController ()

@end

@implementation userInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:238/255.0f green:238/255.0f blue:238/255.0f alpha:1];
    
    PFUser *user = [PFUser currentUser];
    NSString *userobject = user.objectId;
    NSLog(@"user id %@", userobject);
    
    PFQuery *query = [PFQuery queryWithClassName:@"_User"];
    [query whereKey:@"objectId" equalTo:userobject];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *pbject, NSError *error){
        _firstname.text = [pbject objectForKey:@"FirstName"];
        _lastname.text = [pbject objectForKey:@"LastName"];
        _username.text = [pbject objectForKey:@"username"];
        _email.text = [pbject objectForKey:@"email"];
        _country.text = [pbject objectForKey:@"country"];
        _group.text = [pbject objectForKey:@"groupName"];
    
    }];
}

-(IBAction)update:(id)sender {
    PFQuery *queryUpadte = [PFQuery queryWithClassName:@"_User"];

    [queryUpadte getObjectInBackgroundWithId:[PFUser currentUser].objectId
                                  block:^(PFObject *change, NSError *error) {
            change[@"FirstName"] = _firstname.text;
            change[@"LastName"] = _lastname.text;
            change[@"username"] = _username.text;
            change[@"email"] = _email.text;
            change[@"country"] = _country.text;
            change[@"groupName"] = _group.text;
            [change saveEventually];
            [self done];
    }];
    
}

-(void)done {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Done" message:@"We have change your data" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

-(IBAction)changepassword:(id)sender {
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
- (IBAction)deteleAccount:(id)sender {
    PFUser *user = [PFUser currentUser];
    NSString *deleteUser = user.objectId;
    
    PFQuery *query = [PFQuery queryWithClassName:@"_User"];
    [query whereKey:@"objectId" equalTo:deleteUser];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        if (!error) {
            [object deleteInBackground];
            [self DeleteDone];
        }
    }];
}

- (IBAction)backButton:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void)DeleteDone {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Your Account" message:@"Your account has been delete! You will now been taken to the login page" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
    [alert show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
