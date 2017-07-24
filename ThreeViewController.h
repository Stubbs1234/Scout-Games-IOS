//
//  ThreeViewController.h
//  Scout Games
//
//  Created by Alex Stubbs on 18/03/2015.
//  Copyright (c) 2015 Alex Stubbs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <Parse/Parse.h>
#import "FourViewController.h"

@interface ThreeViewController : UIViewController <UIImagePickerControllerDelegate,UINavigationControllerDelegate, UIAlertViewDelegate> {
    NSString *objectId1;
    NSString *paidString;
    NSString *email;
    NSString *StringCountry;
    NSString *objectId;
    NSString *email1;
    NSString *upload;
}


- (IBAction)save:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField * NameOfGame;
@property (strong, nonatomic) IBOutlet UITextField * Needed;
@property (strong, nonatomic) IBOutlet UITextView * des;
@property (strong, nonatomic) IBOutlet UITextField * Group;
@property (strong, nonatomic) IBOutlet UIButton * save;
@property (weak, nonatomic) IBOutlet UILabel *head;
@property (strong, nonatomic) NSURL *videoURL;
@property (strong, nonatomic) PFUser *user;


@end
