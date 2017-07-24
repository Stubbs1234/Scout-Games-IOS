//
//  feedback.h
//  Scout Games
//
//  Created by Alex Stubbs7 on 23/05/2015.
//  Copyright (c) 2015 Alex Stubbs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface feedback : UIViewController <MFMailComposeViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UITextView *textBox;
- (IBAction)sendEmail:(id)sender;
- (IBAction)BackButton:(id)sender;

@end
