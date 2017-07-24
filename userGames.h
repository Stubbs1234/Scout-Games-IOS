//
//  userGames.h
//  Scout Games
//
//  Created by Alex Stubbs7 on 23/05/2015.
//  Copyright (c) 2015 Alex Stubbs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "myGamesCell.h"
#import <Parse/Parse.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface userGames : UIViewController <UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
    NSArray *arrayGames;
    NSString *objectId;
    NSString *StringCountry;
    NSString *Country;
}
@property (strong, nonatomic) IBOutlet UIView *editTheView;
@property (strong, nonatomic) IBOutlet UIButton *backButtonOutlet;
@property (strong, nonatomic) IBOutlet UITableView *myGamesTables;
@property (weak, nonatomic) IBOutlet UIView *detailView;
@property (weak, nonatomic) IBOutlet UILabel *NameOfGame;
@property (weak, nonatomic) IBOutlet UITextView * Items;
@property (weak, nonatomic) IBOutlet UITextView * Des;
@property (strong, nonatomic) IBOutlet UIButton * backBtn;
@property (strong, nonatomic) IBOutlet UIButton * favs;
@property (strong, nonatomic) IBOutlet UIButton * add;
@property (strong, nonatomic) IBOutlet UIButton * video;
@property (strong, nonatomic) NSString *objectIdLike;
@property (strong, nonatomic) IBOutlet UILabel *LabelTitleGame;
@property (strong, nonatomic) IBOutlet UITextField *NameOFGAMEUpdate;
@property (strong, nonatomic) IBOutlet UIButton *done;
- (IBAction)done:(id)sender;
@property (strong, nonatomic) IBOutlet UITextView *iTemsUpdate;
@property (strong, nonatomic) IBOutlet UIButton *videoUpdate;
- (IBAction)videoUpdate:(id)sender;
- (IBAction)update:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *update;
@property (strong, nonatomic) IBOutlet UITextView *DesUpdate;
@property (strong, nonatomic) NSString * videoUrl;
@property (strong, nonatomic) NSURL *videoURL;
@end
