//
//  SecondViewController.h
//  Scout Games
//
//  Created by Alex Stubbs on 17/03/2015.
//  Copyright (c) 2015 Alex Stubbs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "ParseExampleCell.h"
#import <MediaPlayer/MediaPlayer.h>
#import <MessageUI/MessageUI.h>
#import <Social/Social.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreImage/CoreImage.h>



@interface SecondViewController : UIViewController  <UIPrintInteractionControllerDelegate, UIActionSheetDelegate, MFMailComposeViewControllerDelegate, UITableViewDelegate> {
    
    NSArray *GamesArray;
    NSArray *string;
    NSString *objectId;
    NSString *StringCountry;
    NSString *objectId1;
    NSString *email;
    NSString *paidString2;
}

@property (weak, nonatomic) IBOutlet UITableView *gamesTable;
@property (weak, nonatomic) IBOutlet UIView *detailView;
@property (weak, nonatomic) IBOutlet UILabel *NameOfGame;
@property (weak, nonatomic) IBOutlet UITextView * Items;
@property (weak, nonatomic) IBOutlet UITextView * Des;
@property (strong, nonatomic) IBOutlet UIButton * backBtn;
@property (strong, nonatomic) IBOutlet UIButton * favs;
@property (strong, nonatomic) IBOutlet UIButton * add;
@property (strong, nonatomic) IBOutlet UIButton * video;
@property (strong, nonatomic) NSString * videoUrl;
@property (strong, nonatomic) NSString * liked;
@property (strong, nonatomic) PFObject *objectIdLike;
@property (strong, nonatomic) NSString * Name;
@property (strong, nonatomic) NSString * iTem;
@property (strong, nonatomic) NSString * desString;
@property (strong, nonatomic) NSString *AppleWatch;
@property (nonatomic, strong) NSString *mainTitle;
@property (nonatomic, strong) NSString *subTitle;
@property (strong, nonatomic) NSString *imageUrl;
@property (strong, nonatomic) NSURL *webAddress;

- (IBAction)backBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *topPage;

@end

