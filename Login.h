//
//  Login.h
//  Scout Games
//
//  Created by Alex Stubbs on 18/03/2015.
//  Copyright (c) 2015 Alex Stubbs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>
#import <QuartzCore/QuartzCore.h>
#import "FirstViewController.h"

@interface Login : UIViewController {
    NSString *number;
}
@property (strong, nonatomic) IBOutlet UILabel *h1;
@property (strong, nonatomic) IBOutlet UILabel *h2;
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (strong, nonatomic) IBOutlet UILabel *logLabel;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *reEnterPasswordField;
@property (weak, nonatomic) IBOutlet UIView *loginOverlayView;

@property (strong, nonatomic) IBOutlet UIButton *logButton;
@property (strong, nonatomic) IBOutlet UIButton *forget;
@property (strong, nonatomic) IBOutlet UIButton *needAccount;

@property (strong, nonatomic) IBOutlet UITextField *group;

- (IBAction)registerAction:(id)sender;
- (IBAction)registeredButton:(id)sender;

- (IBAction)loginButton:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *loginUsernameField;
@property (weak, nonatomic) IBOutlet UITextField *loginPasswordField;

@end
