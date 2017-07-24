//
//  output.m
//  Scout Games
//
//  Created by Alex Stubbs on 18/03/2015.
//  Copyright (c) 2015 Alex Stubbs. All rights reserved.
//

#import "games.h"
#import "database.h"
#import "DetailViewController.h"

@interface games ()

{
    HomeModel *_homeModel;
    NSArray *_feedItems;
    database *_selectedwalk;
}
@end

@implementation games

#define iPhone4s ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && MAX([UIScreen mainScreen].bounds.size.height,[UIScreen mainScreen].bounds.size.width) == 480)
#define iPhone5 ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && MAX([UIScreen mainScreen].bounds.size.height,[UIScreen mainScreen].bounds.size.width) == 568)
#define iPhone5s ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && MAX([UIScreen mainScreen].bounds.size.height,[UIScreen mainScreen].bounds.size.width) == 568)
#define iPhone6 ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && MAX([UIScreen mainScreen].bounds.size.height,[UIScreen mainScreen].bounds.size.width) == 667)
#define iPhone6Plus ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && MAX([UIScreen mainScreen].bounds.size.height,[UIScreen mainScreen].bounds.size.width) == 736)

- (void)viewDidLoad {
    _feedItems = [[NSArray alloc] init];
    // Create new HomeModel object and assign it to _homeModel variable
    _homeModel = [[HomeModel alloc] init];
    
    // Set this view controller object as the delegate for the home model object
    _homeModel.delegate = self;
    
    // Call the download items method of the home model object
    [_homeModel downloadItems];
    [self performSelector:@selector(filltable)];
    [super viewDidLoad];
    NSLog(@"sec view");
    self.detailView.hidden = YES;
    self.gamesTable.backgroundColor = [UIColor colorWithRed:238/255.0f green:238/255.0f blue:238/255.0f alpha:1];
    self.view.backgroundColor = [UIColor colorWithRed:238/255.0f green:238/255.0f blue:238/255.0f alpha:1];
    [self performSelector:@selector(getPrintImage)];
    [self performSelector:@selector(getWebsiteAddress)];
    
    self.detailView.backgroundColor = [UIColor colorWithRed:238/255.0f green:238/255.0f blue:238/255.0f alpha:1];
    [[_Items layer] setBorderColor:[UIColor blackColor].CGColor];
    [[_Items layer] setBorderWidth:2.0f];
    [[_Des layer] setBorderColor:[UIColor blackColor].CGColor];
    [[_Des layer] setBorderWidth:2.0f];
    
}

/*-(void)filltable {
    PFQuery *retrieveGames = [PFQuery queryWithClassName:@"games"];
    [retrieveGames orderByAscending:@"updatedAt"];
    [retrieveGames findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            GamesArray = [[NSArray alloc] initWithArray:objects];
        }
        [_gamesTable reloadData];
        
    }];
}*/
-(void)itemsDownloaded:(NSArray *)items
{
    // This delegate method will get called when the items are finished downloading
    
    // Set the downloaded items to the array
    _feedItems = items;
    
    // Reload the table view
    [self.gamesTable reloadData];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle  reuseIdentifier:CellIdentifier];

    
    // Get the location to be shown
    database *item = _feedItems[indexPath.row];
    
    // Get references to labels of cell
    cell.textLabel.text = item.NameGame;

    //myCell.textLabel.text = item.miles;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    /*PFObject *tempObject = [GamesArray objectAtIndex:indexPath.row];
    NSLog(@"%@", tempObject.objectId);
    
    _NameOfGame.text = [tempObject objectForKey:@"NameGame"];
    _Items.text = [tempObject objectForKey:@"item"];
    _Des.text = [tempObject objectForKey:@"des"];
    PFFile *video = [tempObject objectForKey:@"Video"];
    _videoUrl = video.url;
    _objectIdLike = [GamesArray objectAtIndex:indexPath.row];
    NSLog(@"Oject id %@", _objectIdLike);*/
    
    [self animateDetailView];
}

- (void) animateDetailView {
    self.detailView.hidden = NO;
    self.backBtnMain.hidden = YES;
}

- (IBAction)backBtn:(id)sender {
    self.detailView.hidden = YES;
    self.backBtnMain.hidden = NO;
    
}

- (IBAction)video:(id)sender {
    if ([_videoUrl isEqualToString:@""]) {
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
                    [self print];
                    NSLog(@"Printing Page");
                    break;
                case 1:
                    [self emailContent];
                    NSLog(@"Game Emailed");
                    break;
                case 2:
                    [self postToTwi];
                    NSLog(@"Posting to twitter");
                    break;
                case 3:
                    [self posttoFace];
                    NSLog(@"Posting to Facebook");
                    break;
                case 4:
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
- (IBAction)backBtnMain:(id)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
}
@end