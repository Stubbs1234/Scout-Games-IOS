//
//  New.h
//  Scout Games
//
//  Created by Alex Stubbs on 18/03/2015.
//  Copyright (c) 2015 Alex Stubbs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>
#import <QuartzCore/QuartzCore.h>

@interface New : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (strong, nonatomic) IBOutlet UILabel *waitsign;
@property (strong, nonatomic) NSArray *dataSourceArray;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIPickerView *picker;

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *reEnterPasswordField;
@property (weak, nonatomic) IBOutlet UITextField *firstName;
@property (weak, nonatomic) IBOutlet UITextField *lastName;
@property (weak, nonatomic) IBOutlet UITextField *Group;
@property (strong, nonatomic) NSString *paymentDone;
@property (strong, nonatomic) NSNumber *booleanYes;
@property (strong, nonatomic) NSNumber *booleanNo;
@property (strong, nonatomic) NSString *Firstname;
@property (strong, nonatomic) NSString *emaillAddress;
@property (strong, nonatomic) NSString *Lastname;
@property (strong, nonatomic) NSString *dateString1;
@end
