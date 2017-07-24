//
//  FirstViewController.h
//  Scout Games
//
//  Created by Alex Stubbs on 17/03/2015.
//  Copyright (c) 2015 Alex Stubbs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "HomeCell1.h"
#import <MediaPlayer/MediaPlayer.h>
#import <MessageUI/MessageUI.h>
#import <Social/Social.h>
#import <iAd/iAd.h>


@interface FirstViewController : UIViewController<UITableViewDelegate, UIPrintInteractionControllerDelegate, UIActionSheetDelegate, MFMailComposeViewControllerDelegate> {
    
    NSArray *HomeArray;
    NSArray *labelArray;
    int timerInt;
    IBOutlet ADBannerView *iAD;
    NSArray *WatchArray;
    NSString *objectId1;
    NSString *objectId2;
    NSString *email;
    NSString *paidString;
    NSString *dateString;
    NSString *dateString1;
    NSString *emailAddress;
    NSString *country;
    NSString *dateFinish;
    NSString *firstName;
    NSString *lastName;
    NSString *trail;
    NSString *dateForString;
    NSString *tenOn;
    NSString *sub;
}

@property (strong, nonatomic) IBOutlet UILabel *userName;
@property (strong, nonatomic) IBOutlet UILabel *home1;
@property (strong, nonatomic) IBOutlet UILabel *home2;
@property (strong, nonatomic) IBOutlet UILabel *home3;
@property (strong, nonatomic) IBOutlet UILabel *home4;
@property (strong, nonatomic) IBOutlet UILabel *home5;
@property (strong, nonatomic) IBOutlet UILabel *home6;
@property (strong, nonatomic) IBOutlet UITableView *hometable;
@property (strong, nonatomic) PFObject *deleteObjectID;
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) NSString *home1String;
@property (strong, nonatomic) NSString *home2String;
@property (strong, nonatomic) NSString *home3String;
@property (strong, nonatomic) NSString *home4String;
@property (strong, nonatomic) NSString *home5String;
@property (strong, nonatomic) NSString *home6String;
@property (strong, nonatomic) IBOutlet UIButton *logout;
@property (weak, nonatomic) IBOutlet UIView *detailView;
@property (weak, nonatomic) IBOutlet UILabel *NameOfGame;
@property (weak, nonatomic) IBOutlet UITextView * Items;
@property (weak, nonatomic) IBOutlet UITextView * Des;
@property (strong, nonatomic) IBOutlet UIButton * backBtn;
@property (strong, nonatomic) IBOutlet UIButton * favs;
@property (strong, nonatomic) IBOutlet UIButton * add;
@property (strong, nonatomic) IBOutlet UIButton * video;
@property (strong, nonatomic) NSString * videoUrl;
@property (strong, nonatomic) NSString * Name;
@property (strong, nonatomic) NSString * iTem;
@property (strong, nonatomic) NSString * desString;
@property (strong, nonatomic) NSString *AppleWatch;
@property (nonatomic, strong) NSString *mainTitle;
@property (nonatomic, strong) NSString *subTitle;
@property (strong, nonatomic) NSString *imageUrl;
@property (strong, nonatomic) NSURL *webAddress;
- (IBAction)backBtn:(id)sender;
- (IBAction)logout:(id)sender;

@end

