//
//  userInfoTableViewController.h
//  Scout Games
//
//  Created by Alex Stubbs7 on 23/05/2015.
//  Copyright (c) 2015 Alex Stubbs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface userInfoViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *firstname;
@property (strong, nonatomic) IBOutlet UITextField *lastname;
@property (strong, nonatomic) IBOutlet UITextField *username;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UITextField *email;
@property (strong, nonatomic) IBOutlet UITextField *group;
@property (strong, nonatomic) IBOutlet UITextField *country;
- (IBAction)update:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *changepassword;
@property (strong, nonatomic) IBOutlet UIButton *update;
- (IBAction)changepassword:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *deleteAccount;
- (IBAction)deteleAccount:(id)sender;
- (IBAction)backButton:(id)sender;

@end
