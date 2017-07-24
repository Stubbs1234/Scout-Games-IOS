//
//  feedback.m
//  Scout Games
//
//  Created by Alex Stubbs7 on 23/05/2015.
//  Copyright (c) 2015 Alex Stubbs. All rights reserved.
//

#import "feedback.h"

@interface feedback ()

@end

@implementation feedback

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:238/255.0f green:238/255.0f blue:238/255.0f alpha:1];
    [[_textBox layer] setBorderColor:[UIColor blackColor].CGColor];
    [[_textBox layer] setBorderWidth:2.0f];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sendEmail:(id)sender {
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate  = self;
    
    //NSString *pageLink = @"http://ioscreator.com";
    //NSString *emailBody = [NSString stringWithFormat:@"Sent from %@", pageLink];
    
    [picker setToRecipients:[NSArray arrayWithObjects:@"feedback@scoutgames.tk", nil]];
    [picker setSubject:@"Feedback"];
    [picker setMessageBody:self.textBox.text isHTML:NO];
    
    
    picker.navigationBar.barStyle = UIStatusBarStyleLightContent;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(IBAction)BackButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
}
@end
