//
//  SecondViewController.m
//  Scout Games
//
//  Created by Alex Stubbs on 17/03/2015.
//  Copyright (c) 2015 Alex Stubbs. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

#define iPhone4s ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && MAX([UIScreen mainScreen].bounds.size.height,[UIScreen mainScreen].bounds.size.width) == 480)
#define iPhone5 ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && MAX([UIScreen mainScreen].bounds.size.height,[UIScreen mainScreen].bounds.size.width) == 568)
#define iPhone5s ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && MAX([UIScreen mainScreen].bounds.size.height,[UIScreen mainScreen].bounds.size.width) == 568)
#define iPhone6 ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && MAX([UIScreen mainScreen].bounds.size.height,[UIScreen mainScreen].bounds.size.width) == 667)
#define iPhone6Plus ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && MAX([UIScreen mainScreen].bounds.size.height,[UIScreen mainScreen].bounds.size.width) == 736)

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"sec view");
    self.detailView.hidden = YES;
    self.gamesTable.backgroundColor = [UIColor colorWithRed:238/255.0f green:238/255.0f blue:238/255.0f alpha:1];
    self.view.backgroundColor = [UIColor colorWithRed:238/255.0f green:238/255.0f blue:238/255.0f alpha:1];
    [self performSelector:@selector(ParseUser)];
    [self performSelector:@selector(getPrintImage)];
    [self performSelector:@selector(getWebsiteAddress)];
    
    self.detailView.backgroundColor = [UIColor colorWithRed:238/255.0f green:238/255.0f blue:238/255.0f alpha:1];
    [[_Items layer] setBorderColor:[UIColor blackColor].CGColor];
    [[_Items layer] setBorderWidth:2.0f];
    [[_Des layer] setBorderColor:[UIColor blackColor].CGColor];
    [[_Des layer] setBorderWidth:2.0f];

}

-(void)ParseUser {
    PFQuery *query = [PFQuery queryWithClassName:@"_User"];
    
    [query whereKey:@"objectId" equalTo:[PFUser currentUser].objectId];
    
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        if (!error) {
            StringCountry = [object objectForKey:@"country"];
            [self checkForCountry];
        }
    }];
}

-(void)checkForCountry {
    
    if ([StringCountry isEqualToString:@"United Kingdom"]) {
        NSLog(@"UK");
        PFQuery *retrieveGames = [PFQuery queryWithClassName:@"ukgames"];
        [retrieveGames orderByAscending:@"updatedAt"];
        [retrieveGames findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                GamesArray = [[NSArray alloc] initWithArray:objects];
            }
            [_gamesTable reloadData];
            
        }];
    } else if ([StringCountry isEqualToString:@"Canada"]) {
        NSLog(@"can");
        PFQuery *retrieveGames = [PFQuery queryWithClassName:@"cangames"];
        [retrieveGames orderByAscending:@"updatedAt"];
        [retrieveGames findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                GamesArray = [[NSArray alloc] initWithArray:objects];
            }
            [_gamesTable reloadData];
            
        }];
    } else if ([StringCountry isEqualToString:@"United States"]) {
        NSLog(@"US");
        PFQuery *retrieveGames = [PFQuery queryWithClassName:@"usgames"];
        [retrieveGames orderByAscending:@"updatedAt"];
        [retrieveGames findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                GamesArray = [[NSArray alloc] initWithArray:objects];
            }
            [_gamesTable reloadData];
            
        }];
    } else if ([StringCountry isEqualToString:@"Australia"]) {
        NSLog(@"Aus");
        PFQuery *retrieveGames = [PFQuery queryWithClassName:@"ausgames"];
        [retrieveGames orderByAscending:@"updatedAt"];
        [retrieveGames findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                GamesArray = [[NSArray alloc] initWithArray:objects];
            }
            [_gamesTable reloadData];
            
        }];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Country Found" message:@"We have not been able to found an country that you are in so you have been put on the UK game list. Please update you information in your account under more" delegate:self cancelButtonTitle:@"Will Do" otherButtonTitles:nil, nil];
        [alert show];
    }

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [GamesArray count];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setBackgroundColor:[UIColor clearColor]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"ParseExampleCell";
    
        ParseExampleCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    PFObject *tempObjects = [GamesArray objectAtIndex:indexPath.row];
    cell.cellTitle.text = [tempObjects objectForKey:@"NameGame"];
    
        return cell;
    }

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
    {
        
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
            PFObject *tempObject = [GamesArray objectAtIndex:indexPath.row];
            NSLog(@"%@", tempObject.objectId);
            
            _NameOfGame.text = [tempObject objectForKey:@"NameGame"];
            _Items.text = [tempObject objectForKey:@"item"];
            _Des.text = [tempObject objectForKey:@"des"];
            PFFile *video = [tempObject objectForKey:@"Video"];
            _videoUrl = video.url;
        _objectIdLike = [GamesArray objectAtIndex:indexPath.row];
            NSLog(@"Oject id %@", _objectIdLike);
        
            [self animateDetailView];
    }

- (void) animateDetailView {
    self.detailView.hidden = NO;
}

- (IBAction)backBtn:(id)sender {
    self.detailView.hidden = YES;

}

- (void) likeImage{
    
    
    [_objectIdLike addUniqueObject:[PFUser currentUser].objectId forKey:@"favs"];
    
    [_objectIdLike saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            [self likedSuccess];
        }
        else {
            [self likedFail];
            
        }
    }];
}

- (void) likedSuccess {
   UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success!" message:@"You have succesfully liked the game" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}



- (void) likedFail {
   UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oooops!" message:@"There was an error when liking the game" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}

- (IBAction)video:(id)sender {
    if (_videoUrl == NULL) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry no video Found" message:@"Sorry no video found for this game" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    } else
    {
    NSURL *videoURL1 = [NSURL URLWithString:_videoUrl];
    
    MPMoviePlayerViewController *mpc = [[MPMoviePlayerViewController alloc] initWithContentURL:videoURL1];
    [mpc.moviePlayer prepareToPlay];
    [mpc.moviePlayer play];
    [mpc.moviePlayer allowsAirPlay];
    mpc.moviePlayer.fullscreen = YES;
    
    [self presentMoviePlayerViewControllerAnimated:mpc];
    }
}

- (IBAction)add:(id)sender {
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:@"Select an option:" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:
                            @"Add to your favourites",
                            @"Print",
                            @"Share via E-mail",
                            @"Share To Twitter",
                            @"Share To Facebook",
                            @"View on the Watch",
                            nil];
    popup.tag = 1;
    [popup showInView:[UIApplication sharedApplication].keyWindow];
}

- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (popup.tag) {
        case 1: {
            switch (buttonIndex) {
                case 0:
                    [self likeImage];
                    NSLog(@"Image Liked");
                    break;
                case 1:
                    [self print];
                    NSLog(@"Printing Page");
                    break;
                case 2:
                    [self emailContent];
                    NSLog(@"Game Emailed");
                    break;
                case 3:
                    [self postToTwi];
                    NSLog(@"Posting to twitter");
                    break;
                case 4:
                    [self posttoFace];
                    NSLog(@"Posting to Facebook");
                    break;
                case 5:
                    [self shareWatch];
                    NSLog(@"Showing on Apple Watch");
                    break;
                default:
                    break;
            }
            break;
        }
        default:
            break;
    }
}



-(void)print{
    
    NSString *url = _imageUrl;
    //@"http://localhost:8888/ScoutGameWebsite/images/logoXcode.png";
    
    NSString *html = [NSString stringWithFormat:@"<html><div align='right'><img src='%@' hight='100' width='100'></div><h1>%@</h1><br><h2>Equipment</h2><br><p>%@</p><br><h2>Description</h2><br><p>%@</p></html>",url,self.NameOfGame.text, self.Items.text, self.Des.text];
    
    UIPrintInteractionController *pic = [UIPrintInteractionController sharedPrintController];
    pic.delegate = self;
    
    UIPrintInfo *printInfo = [UIPrintInfo printInfo];
    printInfo.outputType = UIPrintInfoOutputGeneral;
    printInfo.jobName = @"Scout Games";
    pic.printInfo = printInfo;
    
    UIMarkupTextPrintFormatter *textFormatter = [[UIMarkupTextPrintFormatter alloc] initWithMarkupText:html];
    textFormatter.startPage = 0;
    textFormatter.contentInsets = UIEdgeInsetsMake(72, 72, 72, 72);
    textFormatter.maximumContentWidth = 6*72;
    pic.printFormatter = textFormatter;
    pic.showsPageRange = YES;
    
    void (^comletionHandler)(UIPrintInteractionController *, BOOL, NSError *) = ^(UIPrintInteractionController *printController, BOOL completed, NSError *error) {
        if (!completed && error) {
            NSLog(@"PrintError %@", error);
        }
    };
    
    [pic presentAnimated:YES completionHandler:comletionHandler];
}

-(void)emailContent{
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
        picker.mailComposeDelegate  = self;
        
        NSString *subject = @"Take a look at this game I have found using Scout Games";
        NSString *emailBody = [NSString stringWithFormat:@"Hey!\n\n Check out This Game i have found using Scout Games\n\n Name Of the Game: %@\n\n Equipment Needed: %@\n\n Description: %@\n\n Why don't you download and take a look for your self, and watch the video clip\n\n %@\n\n",self.NameOfGame.text, self.Items.text, self.Des.text, _webAddress];
        
        [picker setSubject:subject];
        [picker setMessageBody:emailBody isHTML:NO];
        
        
        picker.navigationBar.barStyle = UIStatusBarStyleLightContent;
        
        [self presentViewController:picker animated:YES completion:NULL];
    }
    
    - (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
    {
        [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void)postToTwi{
    
    NSString *twetSheetText = [NSString stringWithFormat:@"Check out this game I have found using Scout Games\n\n Game: %@\n\n %@",self.NameOfGame.text, _webAddress];
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController
                                               composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:twetSheetText];
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
    else {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"O Dear!" message:@"It looks like you have not set up Twitter! Please set up Twitter in Setting" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
}

-(void)posttoFace{
    
    NSString *FaceSheetText = [NSString stringWithFormat:@"Check out this game I have found using Scout Games\n\n Game: %@\n\n %@",self.NameOfGame.text, _webAddress];
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        
        SLComposeViewController *faceSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        [faceSheet setInitialText:FaceSheetText];
        [self presentViewController:faceSheet animated:YES completion:nil];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"O Dear!" message:@"It looks like you have not set up Facebook! Please set up Facebook in Setting" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
}


-(void)shareWatch{
    if (iPhone4s) {
        UIAlertView *alret4s = [[UIAlertView alloc] initWithTitle:@"Apple Watch Will Not Work With your iPhone" message:@"Apple Watch is not supported on iPhone 4s" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alret4s show];
    }else {
    
    NSUserDefaults *AppleWatchFound = [[NSUserDefaults alloc] initWithSuiteName:@"group.appleWatchFound"];
    [AppleWatchFound synchronize];
    _AppleWatch = [AppleWatchFound stringForKey:@"foundAnAppleWatch"];
    

        self.NameOfGame.text = _Name;
        NSUserDefaults *name = [[NSUserDefaults alloc] initWithSuiteName:@"group.nameofgame"];
        [name setObject:_Name forKey:@"savedNameOfGame"];
        [name synchronize];
        
        self.Items.text = _iTem;
        NSUserDefaults *item = [[NSUserDefaults alloc] initWithSuiteName:@"group.item"];
        [item setObject:_iTem forKey:@"savediTemForGame"];
        [item synchronize];
        
        self.Des.text = _desString;
        NSUserDefaults *des = [[NSUserDefaults alloc] initWithSuiteName:@"group.des"];
        [des setObject:_desString forKey:@"savedDescription"];
        [des synchronize];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Check it out on the Watch" message:@"It has been saved! Time to check it out on the Watch" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];
    
    /*if ([_AppleWatch isEqualToString:@"AppleWatch Connected"]) { }
    else  {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Apple Watch Found" message:@"Please connect an Apple Watch and try again" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }*/
    }
}

-(void)getPrintImage {
    PFQuery *getImage = [PFQuery queryWithClassName:@"appInfo"];
    [getImage whereKey:@"objectId" equalTo:@"IFoQaVWO7v"];
    
    [getImage getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        if (!error) {
            PFFile *file = [object objectForKey:@"imageOrVideo"];
            _imageUrl = file.url;
        }
    }];

}

-(void)getWebsiteAddress {
    PFQuery *getImage = [PFQuery queryWithClassName:@"appInfo"];
    [getImage whereKey:@"objectId" equalTo:@"XVw4bbwuHH"];
    
    [getImage getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        if (!error) {
            _webAddress = [object objectForKey:@"HomeText"];
        }
    }];
    
}
@end