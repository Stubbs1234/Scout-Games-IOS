//
//  New.m
//  Scout Games
//
//  Created by Alex Stubbs on 18/03/2015.
//  Copyright (c) 2015 Alex Stubbs. All rights reserved.
//

#import "New.h"

@interface New ()

@end

@implementation New
@synthesize picker;
int variabla;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.waitsign.hidden = YES;
    self.picker.hidden = YES;
     _dataSourceArray = @[@"United Kingdom", @"United States", @"Australia", @"Canada"];
    self.view.backgroundColor = [UIColor colorWithRed:238/255.0f green:238/255.0f blue:238/255.0f alpha:1];
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundTap:)]];

}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    [picker setHidden:YES];
    if (textField.editing == YES) {
        [textField resignFirstResponder];
        [picker setHidden:NO];
        variabla = 1;
    }
NSLog(@"variabla %d",variabla);
[picker reloadAllComponents];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
{
    if (variabla == 1) {
        return [_dataSourceArray count];
    }
    else {
        return 0;
    }
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
{
    if (variabla == 1) {
        return [_dataSourceArray objectAtIndex:row];
    }
    else{
        return 0;
    }
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSString *text = [self pickerView:pickerView titleForRow:row forComponent:component];
    UITextField *current = nil;
    if (variabla == 1) current = self.textField;
    current.text = text;
    
}

-(void)backgroundTap:(UITapGestureRecognizer *)tapGR{
    self.picker.hidden = YES;
    // And maybe..
    variabla = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)registerAction:(id)sender {
    [_usernameField resignFirstResponder];
    [_emailField resignFirstResponder];
    [_passwordField resignFirstResponder];
    [_reEnterPasswordField resignFirstResponder];
    [_firstName resignFirstResponder];
    [_lastName resignFirstResponder];
    [_Group resignFirstResponder];
    [self checkFieldsComplete];
}

- (void) checkFieldsComplete {
    if ([_usernameField.text isEqualToString:@""] || [_emailField.text isEqualToString:@""] || [_passwordField.text isEqualToString:@""] || [_reEnterPasswordField.text isEqualToString:@""] || [_firstName.text isEqualToString:@""] || [_lastName.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oooopss!" message:@"You need to complete all fields" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else {
        [self checklength];
    }
}
- (void) checklength {
    if (_passwordField.text.length >= 8) {
        [self checkPasswordsMatch];
    } else {
        UIAlertView *alertLength = [[UIAlertView alloc] initWithTitle:@"What About The Hackers" message:@"Your password needs to be more then 8 letters long to keep out the hackers" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alertLength show];
    }
}
- (void) checkPasswordsMatch {
    if (![_passwordField.text isEqualToString:_reEnterPasswordField.text] ) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oooopss!" message:@"Passwords don't match" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    } else if (_textField == NULL) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oooopss!" message:@"Country not selected" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
    }else {
        NSString *emailAddress345 = _emailField.text;
        PFQuery *query = [PFQuery queryWithClassName:@"deletedUsers"];
        [query whereKey:@"email" equalTo:emailAddress345];
        [query countObjectsInBackgroundWithBlock:^(int number, NSError *error) {
            if(number > 0) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry You Cannot Sign Up" message:@"Sorry you cannot sign up as you have already been apart of Scout Games" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [alert show];
            } else {
                [self registerNewUser];
            }
        }];
    }
}

- (void) registerNewUser {
    self.waitsign.hidden = NO;
    _usernameField.hidden = YES;
    _emailField.hidden = YES;
    _passwordField.hidden = YES;
    _reEnterPasswordField.hidden = YES;
    _firstName.hidden = YES;
    _lastName.hidden = YES;
    _textField.hidden = YES;
    _Group.hidden = YES;
    NSLog(@"registering....");
    _emaillAddress = _emailField.text;
    _Firstname = _firstName.text;
    _Lastname = _lastName.text;
    PFUser *newUser = [PFUser user];
    newUser.username = _usernameField.text;
    newUser.email = _emailField.text;
    newUser.password = _passwordField.text;
    newUser[@"FirstName"] = _firstName.text;
    newUser[@"LastName"] = _lastName.text;
    newUser[@"country"] = _textField.text;
    newUser[@"groupName"] = _Group.text;
    
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            NSLog(@"Registration success!");
            //_loginPasswordField.text = nil;
            //_loginUsernameField.text = nil;
            _usernameField.text = nil;
            _passwordField.text = nil;
            _reEnterPasswordField.text = nil;
            _emailField.text = nil;
            _firstName.text=nil;
            _lastName.text=nil;
            _textField.text=nil;
            _Group.text=nil;
            [self checkforEmail];
            [self DayTrail];
        }
        else {
            
            NSLog(@"There was an error in registration");
        }
    }];
}

-(void)checkforEmail {
    UIAlertView *alert1 = [[UIAlertView alloc] initWithTitle:@"Please check your emails" message:@"Please now check your emails and comfirm that you are signing up" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", @"Contact Us", nil];
    [alert1 show];
    alert1.tag = 1;
    
}

-(void)DayTrail {
    NSDate *todaysDate = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setMonth:1];
    NSDate *targetDate = [gregorian dateByAddingComponents:dateComponents toDate:todaysDate  options:0];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    _dateString1 = [dateFormatter stringFromDate:targetDate];
    NSLog(@"A month on %@", _dateString1);
    
    NSString *objectId;
    PFUser *user = [PFUser currentUser];
    objectId = (user.objectId);
    NSLog(@"user id %@", objectId);
    
    NSString *message = [NSString stringWithFormat:@"Your trial ends on the %@", _dateString1];
    
    PFQuery *query = [PFQuery queryWithClassName:@"_User"];
    
    [query getObjectInBackgroundWithId:objectId block:^(PFObject *object, NSError *error) {
        if (!error) {
            object[@"day30"] = _dateString1;
            object[@"trial"] = @YES;
            [object saveInBackground];
            UIAlertView *done = [[UIAlertView alloc] initWithTitle:@"Your Trial" message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [done show];
            
        } else {
            UIAlertView *notDone = [[UIAlertView alloc] initWithTitle:@"Error" message:@"There was an error. Please trying a again later" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [notDone show];
        }
    }];
    
}

-(void)checktosee {
    _usernameField.enabled = NO;
    _passwordField.enabled = NO;
    _reEnterPasswordField.enabled = NO;
    _emailField.enabled = NO;
    _firstName.enabled = NO;
    _lastName.enabled = NO;
    _textField.enabled = NO;
    _Group.enabled = NO;

    PFQuery *query = [PFQuery queryWithClassName:@"_User"];
    [query whereKey:@"email" equalTo:_emaillAddress];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        NSString *doneIt = [object objectForKey:@"emailVerified"];
        if ([doneIt boolValue] == 1) {
            [self sendSignupEmail];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Great Thanks For that" message:@"You will now get an email in the next 5 minutes with more information about Scout Games" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
            [self dismissViewControllerAnimated:YES completion:nil];
        } else {
            [self noNotDone];
        }
    
    }];
    
}

-(void)sendSignupEmail {
    
    [PFCloud callFunction:@"signup" withParameters:@{@"name": _Firstname,
                                                     @"lastName": _Lastname,
                                                     @"email": _emaillAddress}];
    
    [PFCloud callFunctionInBackground:@"subscribeUserToMailingList" withParameters:@{@"listid":@"b389ee29b0",@"email":_emaillAddress,@"mergevars":@{@"FNAME":_Firstname,@"LNAME":_Lastname}}
                                block:^(NSString *result, NSError *error){
                                    if (error) {
                                        //error
                                    } else {
                                        
                                    }
                                }];
}

-(void)noNotDone {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Sorry you have not verified your email address" delegate:self cancelButtonTitle:nil otherButtonTitles:@"I will try again", @"Contact Us", nil];
    [alert show];
    alert.tag = 2;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 1) {
        if (buttonIndex != [alertView cancelButtonIndex]) {
        [self checktosee];
    }
    } else if (alertView.tag == 2) {
        if (buttonIndex != [alertView cancelButtonIndex]) {
            [self checktosee];
        }
    }
    
}
-(IBAction)textFieldReturn:(id)sender
{
    [sender resignFirstResponder];}

@end
