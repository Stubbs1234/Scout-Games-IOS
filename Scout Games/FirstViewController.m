//
//  FirstViewController.m
//  Scout Games
//
//  Created by Alex Stubbs on 17/03/2015.
//  Copyright (c) 2015 Alex Stubbs. All rights reserved.
//

#import "FirstViewController.h"


@interface FirstViewController ()

@end

@implementation FirstViewController
//set cell deleteing

#define iPhone4s ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && MAX([UIScreen mainScreen].bounds.size.height,[UIScreen mainScreen].bounds.size.width) == 480)
#define iPhone5 ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && MAX([UIScreen mainScreen].bounds.size.height,[UIScreen mainScreen].bounds.size.width) == 568)
#define iPhone5s ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && MAX([UIScreen mainScreen].bounds.size.height,[UIScreen mainScreen].bounds.size.width) == 568)
#define iPhone6 ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && MAX([UIScreen mainScreen].bounds.size.height,[UIScreen mainScreen].bounds.size.width) == 667)
#define iPhone6Plus ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && MAX([UIScreen mainScreen].bounds.size.height,[UIScreen mainScreen].bounds.size.width) == 736)

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.detailView.hidden = YES;

    self.view.backgroundColor = [UIColor colorWithRed:238/255.0f green:238/255.0f blue:238/255.0f alpha:1];
    self.hometable.backgroundColor = [UIColor colorWithRed:238/255.0f green:238/255.0f blue:238/255.0f alpha:1];
    
    [self performSelector:@selector(retrieveLikedGames)];
    [self performSelector:@selector(retrieveLikedGames2)];
    [self performSelector:@selector(checkForSub)];
    [self performSelector:@selector(getFirstName)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)getFirstName {
    
    PFQuery *query = [PFQuery queryWithClassName:@"_User"];
    
    [query whereKey:@"objectId" equalTo:[PFUser currentUser].objectId];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        if (!error) {
            NSString *firstNameGet;
            firstNameGet = [object objectForKey:@"FirstName"];
            if (firstNameGet == NULL) {
                _userName.text = @"No Name Found";
            } else {
                NSString *welcomeMess = [NSString stringWithFormat:@"Welcome to Scout Games: %@", firstNameGet];
                _userName.text = welcomeMess;
            }
        } else {
        _userName.text = @"There was an Error getting data";
        }
    }];
}

-(void) retrieveLikedGames {
 PFQuery *GetFavorites = [PFQuery queryWithClassName:@"games"];
 [GetFavorites whereKey:@"favs" equalTo:[PFUser currentUser].objectId];
 
 [GetFavorites findObjectsInBackgroundWithBlock:^(NSArray *objects1, NSError *error)  {
 if (!error) {
     HomeArray = [[NSArray alloc] initWithArray:objects1];
     WatchArray = [[NSArray alloc] initWithArray:objects1];
 }
     [_hometable reloadData];
 }

  ];}

-(void) retrieveLikedGames2 {
    PFQuery *GetFavorites = [PFQuery queryWithClassName:@"games"];
    [GetFavorites whereKey:@"favs" equalTo:[PFUser currentUser].objectId];
    
    [GetFavorites findObjectsInBackgroundWithBlock:^(NSArray *objects1, NSError *error)  {
        if (!error) {
            WatchArray = [[NSArray alloc] initWithArray:objects1];
            NSLog(@"does this help %@", WatchArray);
            [self storeinArray];
        }
    }
     
     ];}

-(void)storeinArray {
    NSUserDefaults *getTableArray = [[NSUserDefaults alloc] initWithSuiteName:@"group.scoutgamestable"];
    [getTableArray setObject:WatchArray forKey:@"getTableArray"];
    [getTableArray synchronize];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    BOOL hasMatches = [HomeArray count] > 0;
    return hasMatches ? [HomeArray count] : 1;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self deleteParseFavs];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *CellIdentifier = @"HomeCell";
    BOOL hasMatches = [HomeArray count] > 0;
    
    HomeCell1 *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (hasMatches) {
        PFObject *tempObjects = [HomeArray objectAtIndex:indexPath.row];
        
        cell.cellTitle.text = [tempObjects objectForKey:@"NameGame"];
        
    } else {
        
        cell.cellTitle.text = @"No Data Found";
        
    }
    cell.backgroundColor = [UIColor colorWithRed:238/255.0f green:238/255.0f blue:238/255.0f alpha:1];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    PFObject *tempObject = [HomeArray objectAtIndex:indexPath.row];
    NSLog(@"%@", tempObject.objectId);
    
    _NameOfGame.text = [tempObject objectForKey:@"NameGame"];
    _Items.text = [tempObject objectForKey:@"item"];
    _Des.text = [tempObject objectForKey:@"des"];
    PFFile *video = [tempObject objectForKey:@"Video"];
    _videoUrl = video.url;
    NSLog(@"got a video %@", _videoUrl);
    _deleteObjectID = [HomeArray objectAtIndex:indexPath.row];
    NSLog(@"%@", _deleteObjectID);
    
    [self animateDetailView];
}

- (void) animateDetailView {
    self.detailView.hidden = NO;
    if (iPhone4s){
        _detailView.frame = CGRectMake(0, 17, 320, 450);
        self.detailView.backgroundColor = [UIColor colorWithRed:238/255.0f green:238/255.0f blue:238/255.0f alpha:1];
        _backBtn.frame = CGRectMake(8, 10, 46, 30);
        [[_Items layer] setBorderColor:[UIColor blackColor].CGColor];
        [[_Items layer] setBorderWidth:2.0f];
        [[_Des layer] setBorderColor:[UIColor blackColor].CGColor];
        [[_Des layer] setBorderWidth:2.0f];
        _add.frame= CGRectMake(265, 10, 46, 30);
    }
    
    if (iPhone5) {
        _detailView.frame = CGRectMake(0, 17, 320, 500);
        self.detailView.backgroundColor = [UIColor colorWithRed:238/255.0f green:238/255.0f blue:238/255.0f alpha:1];
        [[_Items layer] setBorderColor:[UIColor blackColor].CGColor];
        [[_Items layer] setBorderWidth:2.0f];
        [[_Des layer] setBorderColor:[UIColor blackColor].CGColor];
        [[_Des layer] setBorderWidth:2.0f];
    }
    
    if (iPhone5s) {
        _detailView.frame = CGRectMake(0, 17, 320, 500);
        self.detailView.backgroundColor = [UIColor colorWithRed:238/255.0f green:238/255.0f blue:238/255.0f alpha:1];
        [[_Items layer] setBorderColor:[UIColor blackColor].CGColor];
        [[_Items layer] setBorderWidth:2.0f];
        [[_Des layer] setBorderColor:[UIColor blackColor].CGColor];
        [[_Des layer] setBorderWidth:2.0f];
    }
    
    if (iPhone6) {
        _detailView.frame = CGRectMake(0, 17, 400, 602);
        self.detailView.backgroundColor = [UIColor colorWithRed:238/255.0f green:238/255.0f blue:238/255.0f alpha:1];
        [[_Items layer] setBorderColor:[UIColor blackColor].CGColor];
        [[_Items layer] setBorderWidth:2.0f];
        [[_Des layer] setBorderColor:[UIColor blackColor].CGColor];
        [[_Des layer] setBorderWidth:2.0f];
        _add.frame= CGRectMake(320, 10, 46, 30);
    }
    
    if (iPhone6Plus) {
        _detailView.frame = CGRectMake(0, 17, 420, 736);
        self.detailView.backgroundColor = [UIColor colorWithRed:238/255.0f green:238/255.0f blue:238/255.0f alpha:1];
        [[_Items layer] setBorderColor:[UIColor blackColor].CGColor];
        [[_Items layer] setBorderWidth:2.0f];
        [[_Des layer] setBorderColor:[UIColor blackColor].CGColor];
        [[_Des layer] setBorderWidth:2.0f];
        _add.frame= CGRectMake(360, 13, 46, 30);
        
    }
}

- (IBAction)backBtn:(id)sender {
    self.detailView.hidden = YES;
}

- (IBAction)logout:(id)sender {
    [PFUser logOutInBackground];
    [self performSegueWithIdentifier:@"logout" sender:self];
    
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
                            @"Delete from your favourites",
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
                    [self deleteParseFavs];
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

-(void)deleteParseFavs {
    
    PFQuery *query = [PFQuery queryWithClassName:@"games"];
    [query whereKey:@"favs" equalTo:[PFUser currentUser].objectId];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
        if (!error) {
            PFObject *event = _deleteObjectID;    // note using 'objects', not 'eventObjects'
            [event removeObject:[PFUser currentUser].objectId forKey:@"favs"];
            self.detailView.hidden = YES;
            [self deleteSuccess];
        } else if (error) {
            [self deleteFail];
        }
        
        [PFObject saveAll:objects];
    }];
}
-(void)deleteSuccess {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Game Delete" message:@"The game as been deleted from your favourite List" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
    [_hometable reloadData];
}

-(void)deleteFail {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Game Delete" message:@"The game as not been deleted from your favourite List" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
}

-(void)checkForSub {
    
    
    PFQuery *query = [PFQuery queryWithClassName:@"_User"];
    
    [query whereKey:@"objectId" equalTo:[PFUser currentUser].objectId];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        dateString = [object objectForKey:@"renewDate"];
        dateString1 = [object objectForKey:@"day30"];
        trail = [object objectForKey:@"trial"];
        tenOn = [object objectForKey:@"tenOn"];
        sub = [object objectForKey:@"sub"];
        NSLog(@"%@, %@, %@", trail, dateString1, dateString);
        [self checkTrial];
    }];

}

-(void)checkTrial {
    NSDate *date = [NSDate date];
    NSDateFormatter *datefor = [[NSDateFormatter alloc] init];
    [datefor setDateFormat:@"dd-MM-yyyy"];
    dateForString  = [datefor stringFromDate:date];
    dateFinish = [datefor stringFromDate:date];
    NSLog(@"%@", dateForString);
    
    if ([sub boolValue] == 1) {
        [self showAlertDate];
        NSLog(@"%@", sub);
    }else if ([trail boolValue] == 1) {
        NSLog(@"%@", trail);
        [self showAlertDateTrail];
    }else if ([tenOn boolValue] == 1) {
        NSLog(@"%@", tenOn);
        [self runUserData];
    } else {
        NSString *userId;
        userId = [PFUser currentUser].objectId;
        [PFCloud callFunction:@"warning" withParameters:@{@"objectId":userId}];
    }
}


-(void)showAlertDate {
    //subscriptation
    NSComparisonResult result = [dateForString compare:dateString];
    switch (result)
    {
        case NSOrderedAscending:
            NSLog(@"Future Date");
            [self fatDate];
            break;
        case NSOrderedSame:
            NSLog(@"Today/Null Date Passed");
            [self showAlertsSub];
            break;
        case NSOrderedDescending:
            NSLog(@"Earlier Date");
            break;
        default:
            NSLog(@"Error Comparing Dates");
            break;
    }
}

-(void)showAlertDateTrail {
    //trial
    NSComparisonResult result = [dateForString compare:dateString1];
    switch (result)
    {
        case NSOrderedAscending:
            NSLog(@"Future Date");
            [self fatDate];
            break;
        case NSOrderedSame:
            NSLog(@"Today/Null Date Passed");
            [self showAlertDateTrail];
            break;
        case NSOrderedDescending:
            NSLog(@"Earlier Date");
            break;
        default:
            NSLog(@"Error Comparing Dates");
            break;
    }
}

-(void)fatDate {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You have 10 Days!" message:@"As you have missed the day you were ment to Subscrbire/ renew we are giving you 10 Days from now to subscrbire/renew your accout. Failure to do so means your account will be cancel" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
    
    NSString *dateStringinHouse;
    NSDate *todaysDate = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setDay:10];
    NSDate *targetDate = [gregorian dateByAddingComponents:dateComponents toDate:todaysDate  options:0];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    dateStringinHouse = [dateFormatter stringFromDate:targetDate];
    NSLog(@"10 on %@", dateStringinHouse);
    
    PFQuery *query = [PFQuery queryWithClassName:@"_User"];
    [query whereKey:@"objectId" equalTo:[PFUser currentUser].objectId];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        if (!error) {
        object[@"Day10On"] = dateStringinHouse;
        [object saveEventually];
            [self deleteTrial];
        }
     
    }];
    
}

-(void)deleteTrial {
    
}

-(void)showAlertsSub {
 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Your subscription is out of date" message:@"Sorry but your subscriptation is due to date" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Take me to update it", @"I would like to cancel", nil];
 alert.tag = 1;
 [alert show];
}

-(void)showAlertTrial {
 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Your trial has ended" message:@"Sorry but your trial has ended" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Take me to subscribe", @"I would like to cancel",nil];
 alert.tag = 2;
 [alert show];

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1) {
    
        if(buttonIndex == [alertView firstOtherButtonIndex])
        {
        NSLog(@"selected.");
        [self performSegueWithIdentifier:@"store" sender:self];
        } else {
            [self sureAlert];
        }} else if (alertView.tag == 2) {
        if(buttonIndex == [alertView firstOtherButtonIndex])
        {
            NSLog(@"selected.");
            [self performSegueWithIdentifier:@"store" sender:self];
        } else {
            [self sureAlert];
        }
        } else if (alertView.tag == 3) {
            if (buttonIndex == [alertView firstOtherButtonIndex]) {
                [self runUserData];
            } else {
                [self showAlertDate];
            }
        }else if (alertView.tag == 4) {
            if (buttonIndex == [alertView firstOtherButtonIndex]) {
                [self runUserData];
            } else {
                [self showAlertDate];
            }
        }
    }
    
-(void)sureAlert {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Are you sure?" message:@"Are you sure that you want to cancel the subscriptation?" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Yes", @"No", nil];
    [alert show];
    alert.tag =3;
    }

-(void)sureAlertTrial {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Are you sure?" message:@"Are you sure that you want to be remove?" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Yes", @"No", nil];
    [alert show];
    alert.tag =4;
}

-(void)runUserData {
    NSLog(@"Running Delete Process");
    PFQuery *query = [PFQuery queryWithClassName:@"_User"];
    
    [query whereKey:@"objectId" equalTo:[PFUser currentUser].objectId];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        if (!error) {
        emailAddress = [object objectForKey:@"email"];
        country = [object objectForKey:@"country"];
        NSLog(@"Saved Data %@, %@, %@", emailAddress, country, dateFinish);
            [self wait5];
        }
    }];
}

-(void)wait5 {
    [NSTimer scheduledTimerWithTimeInterval:5.0f
                                     target:self selector:@selector(moveServer) userInfo:nil repeats:NO];
    
}

-(void)moveServer {
    NSLog(@"Move Server");
     NSLog(@"Saved Data %@, %@, %@", emailAddress, country, dateFinish);
    PFObject *moveServer = [PFObject objectWithClassName:@"deletedUsers"];
    NSLog(@"runing upload");
    if (emailAddress) moveServer[@"email"] = emailAddress;
    NSLog(@"email address");
    if (country) moveServer[@"country"] = country;
    NSLog(@"conutry");
    if (dateFinish) moveServer[@"dateFinish"] = dateFinish;
    NSLog(@"date");
    NSLog(@"Saving");
    [moveServer saveInBackgroundWithBlock:^(BOOL success, NSError *error) {
        NSLog(@"save comptele");
        if (!error) {
            NSLog(@"starting fun");
        }
        [self deleteUser];

    }];
}

-(void)deleteUser {
    NSLog(@"Delete User");
    NSString *logOutId;
    logOutId = [PFUser currentUser].objectId;
    [PFUser logOutInBackground];
    [PFCloud callFunction:@"delete" withParameters:@{@"ojectId":logOutId}];
    [self logout2];
    [self sendEmails];
}

-(void)sendEmails {
    [PFCloud callFunction:@"remove" withParameters:@{@"email": emailAddress}];
}

-(void)logout2 {
    [self performSegueWithIdentifier:@"logout" sender:self];
}
@end