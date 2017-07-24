//
//  userGames.m
//  Scout Games
//
//  Created by Alex Stubbs7 on 23/05/2015.
//  Copyright (c) 2015 Alex Stubbs. All rights reserved.
//

#import "userGames.h"

@interface userGames ()

@end

@implementation userGames

#define iPhone4s ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && MAX([UIScreen mainScreen].bounds.size.height,[UIScreen mainScreen].bounds.size.width) == 480)
#define iPhone5 ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && MAX([UIScreen mainScreen].bounds.size.height,[UIScreen mainScreen].bounds.size.width) == 568)
#define iPhone5s ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && MAX([UIScreen mainScreen].bounds.size.height,[UIScreen mainScreen].bounds.size.width) == 568)
#define iPhone6 ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && MAX([UIScreen mainScreen].bounds.size.height,[UIScreen mainScreen].bounds.size.width) == 667)
#define iPhone6Plus ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && MAX([UIScreen mainScreen].bounds.size.height,[UIScreen mainScreen].bounds.size.width) == 736)

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.detailView.hidden = YES;
    self.editTheView.hidden = YES;
    [self performSelector:@selector(checkForUserId)];
    self.view.backgroundColor = [UIColor colorWithRed:238/255.0f green:238/255.0f blue:238/255.0f alpha:1];
    self.myGamesTables.backgroundColor = [UIColor colorWithRed:238/255.0f green:238/255.0f blue:238/255.0f alpha:1];
}

-(void)checkForUserId {
    PFUser *user = [PFUser currentUser];
    objectId = (user.objectId);
    NSLog(@"user id %@", objectId);
    [self ParseUser];
}

-(void)ParseUser {
    PFQuery *query = [PFQuery queryWithClassName:@"_User"];
    
    [query whereKey:@"objectId" equalTo:objectId];
    
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
        Country = @"ukgames";
        PFQuery *retrieveGames = [PFQuery queryWithClassName:@"ukgames"];
        [retrieveGames whereKey:@"userUpload" equalTo:objectId];
        [retrieveGames findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                arrayGames = [[NSArray alloc] initWithArray:objects];
            }
            [_myGamesTables reloadData];
            NSLog(@"Array %@", arrayGames);
            
        }];
    } else if ([StringCountry isEqualToString:@"Canada"]) {
        NSLog(@"can");
        Country = @"cangames";
        PFQuery *retrieveGames = [PFQuery queryWithClassName:@"cangames"];
        [retrieveGames orderByAscending:@"updatedAt"];
        [retrieveGames findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                arrayGames = [[NSArray alloc] initWithArray:objects];
            }
            [_myGamesTables reloadData];
            NSLog(@"Array %@", arrayGames);
            
        }];
    } else if ([StringCountry isEqualToString:@"United States"]) {
        NSLog(@"US");
        Country = @"usgames";
        PFQuery *retrieveGames = [PFQuery queryWithClassName:@"usgames"];
        [retrieveGames orderByAscending:@"updatedAt"];
        [retrieveGames findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                arrayGames = [[NSArray alloc] initWithArray:objects];
            }
            [_myGamesTables reloadData];
            NSLog(@"Array %@", arrayGames);
            
        }];
    } else if ([StringCountry isEqualToString:@"Australia"]) {
        NSLog(@"Aus");
        Country = @"ausgames";
        PFQuery *retrieveGames = [PFQuery queryWithClassName:@"ausgames"];
        [retrieveGames orderByAscending:@"updatedAt"];
        [retrieveGames findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                arrayGames = [[NSArray alloc] initWithArray:objects];
            }
            [_myGamesTables reloadData];
            NSLog(@"Array %@", arrayGames);
            
        }];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Country Found" message:@"We have not been able to found an country that you are in so you have been put on the UK game list. Please update you information in your account under more" delegate:self cancelButtonTitle:@"Will Do" otherButtonTitles:nil, nil];
        [alert show];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    BOOL hasMatches = [arrayGames count] > 0;
    return hasMatches ? [arrayGames count] : 1;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setBackgroundColor:[UIColor clearColor]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
     BOOL hasMatches = [arrayGames count] > 0;
    
    static NSString *CellIdentifier = @"Cell";
    
    myGamesCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (hasMatches) {
         PFObject *tempObjects = [arrayGames objectAtIndex:indexPath.row];
    
    cell.cellTitle.text = [tempObjects objectForKey:@"NameGame"];
    
    } else {
        
        cell.cellTitle.text = @"No Data Found";
        
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    PFObject *tempObject = [arrayGames objectAtIndex:indexPath.row];
    NSLog(@"%@", tempObject.objectId);
    
    _NameOfGame.text = [tempObject objectForKey:@"NameGame"];
    _Items.text = [tempObject objectForKey:@"item"];
    _Des.text = [tempObject objectForKey:@"des"];
    _objectIdLike = tempObject.objectId;
    PFFile *video = [tempObject objectForKey:@"Video"];
    _videoUrl = video.url;
    NSLog(@"Oject id %@", _objectIdLike);
    
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

- (IBAction)backBtn1:(id)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
    self.detailView.hidden = YES;
    
}

- (IBAction)add:(id)sender {
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:@"Select an option:" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:
                            @"Edit the Game",
                            @"Delete the Game",
                            nil];
    popup.tag = 1;
    [popup showInView:[UIApplication sharedApplication].keyWindow];
}

- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (popup.tag) {
        case 1: {
            switch (buttonIndex) {
                case 0:
                    [self editGame];
                    NSLog(@"Edit Game");
                    break;
                case 1:
                    [self deleteGame];
                    NSLog(@"Delete Game");
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

-(void)editGame {
    
    PFQuery *queryGet = [PFQuery queryWithClassName:Country];
    
    [queryGet getObjectInBackgroundWithId:_objectIdLike block:^(PFObject *objectGet, NSError *error) {
        if (!error) {
            NSString *getTitle = [objectGet objectForKey:@"NameGame"];
            NSString *getNameAndTitle = [NSString stringWithFormat:@"Your editing the game %@", getTitle];
            _LabelTitleGame.text = getNameAndTitle;
            
            _NameOFGAMEUpdate.text = [objectGet objectForKey:@"NameGame"];
            _iTemsUpdate.text = [objectGet objectForKey:@"item"];
            _DesUpdate.text = [objectGet objectForKey:@"des"];
        }
    }];
    
    self.editTheView.hidden = NO;
    self.editTheView.backgroundColor = [UIColor colorWithRed:238/255.0f green:238/255.0f blue:238/255.0f alpha:1];
    
    if (iPhone4s){
        _editTheView.frame = CGRectMake(0, 17, 320, 450);
        [[_iTemsUpdate layer] setBorderColor:[UIColor blackColor].CGColor];
        [[_iTemsUpdate layer] setBorderWidth:2.0f];
        [[_DesUpdate layer] setBorderColor:[UIColor blackColor].CGColor];
        [[_DesUpdate layer] setBorderWidth:2.0f];
    }
    
    if (iPhone5) {
        _editTheView.frame = CGRectMake(0, 17, 320, 500);
        [[_iTemsUpdate layer] setBorderColor:[UIColor blackColor].CGColor];
        [[_iTemsUpdate layer] setBorderWidth:2.0f];
        [[_DesUpdate layer] setBorderColor:[UIColor blackColor].CGColor];
        [[_DesUpdate layer] setBorderWidth:2.0f];
    }
    
    if (iPhone5s) {
        _editTheView.frame = CGRectMake(0, 17, 320, 500);
        [[_iTemsUpdate layer] setBorderColor:[UIColor blackColor].CGColor];
        [[_iTemsUpdate layer] setBorderWidth:2.0f];
        [[_DesUpdate layer] setBorderColor:[UIColor blackColor].CGColor];
        [[_DesUpdate layer] setBorderWidth:2.0f];
    }
    
    if (iPhone6) {
        _editTheView.frame = CGRectMake(0, 17, 400, 602);
        [[_iTemsUpdate layer] setBorderColor:[UIColor blackColor].CGColor];
        [[_iTemsUpdate layer] setBorderWidth:2.0f];
        [[_DesUpdate layer] setBorderColor:[UIColor blackColor].CGColor];
        [[_DesUpdate layer] setBorderWidth:2.0f];
    }
    
    if (iPhone6Plus) {
        _editTheView.frame = CGRectMake(0, 17, 420, 736);
        [[_iTemsUpdate layer] setBorderColor:[UIColor blackColor].CGColor];
        [[_iTemsUpdate layer] setBorderWidth:2.0f];
        [[_DesUpdate layer] setBorderColor:[UIColor blackColor].CGColor];
        [[_DesUpdate layer] setBorderWidth:2.0f];
    }

    
}

-(void)deleteGame {
    
    PFQuery *queryDetele = [PFQuery queryWithClassName:Country];
    [queryDetele getObjectInBackgroundWithId:_objectIdLike block:^(PFObject *detele, NSError *error) {
        if (!error) {
            [detele deleteInBackground];
            [self success1];
        }
    }];
}

-(void)success1 {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Deleted" message:@"Your Game as been deleted" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
}

- (IBAction)videoUpdate:(id)sender {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            UIImagePickerController *picker = [[UIImagePickerController alloc]init];
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            picker.delegate = self;
            picker.allowsEditing = NO;
            
            NSArray *mediaTypes = [[NSArray alloc]initWithObjects:(NSString *)kUTTypeMovie, nil];
            
            picker.mediaTypes = mediaTypes;
            
            [self presentViewController:picker animated:YES completion:nil];
            
        } else {
            
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"I'm afraid there's no camera on this device!" delegate:nil cancelButtonTitle:@"Dang!" otherButtonTitles:nil, nil];
            [alertView show];
        }
        
        
        NSLog(@"Filming working");
    }

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
        // grab our movie URL
        NSURL *chosenMovie = [info objectForKey:UIImagePickerControllerMediaURL];
        
        // save it to the documents directory (option 1)
        _videoURL = [self grabFileURL:@"video.mov"];
        NSData *movieData = [NSData dataWithContentsOfURL:chosenMovie];
        [movieData writeToURL:_videoURL atomically:YES];
        NSLog(@"Can save video");
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
- (NSURL*)grabFileURL:(NSString *)fileName {
        
 // find Documents directory
    NSURL *documentsURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
        
// append a file name to it
documentsURL = [documentsURL URLByAppendingPathComponent:fileName];
        
return documentsURL;
}

- (IBAction)update:(id)sender {
    
    if (_videoURL == nil) {
        PFQuery *queryUpadte = [PFQuery queryWithClassName:Country];
        
        [queryUpadte getObjectInBackgroundWithId:_objectIdLike block:^ (PFObject *update, NSError *error) {
            if (!error) {
                update[@"NameGame"] = _NameOFGAMEUpdate.text;
                update[@"item"] = _iTemsUpdate.text;
                update[@"des"] = _DesUpdate.text;
                [update saveInBackground];
                [self success];
                [self getTheData];
            }
        }];
        
    } else {
    
    NSData *videoData = [NSData dataWithContentsOfURL:_videoURL];
    PFFile *videoGame = [PFFile fileWithName:@"Video.mov" data:videoData];
    
    PFQuery *queryUpadte = [PFQuery queryWithClassName:Country];
    
    [queryUpadte getObjectInBackgroundWithId:_objectIdLike block:^ (PFObject *update, NSError *error) {
        if (!error) {
            update[@"NameGame"] = _NameOFGAMEUpdate.text;
            update[@"item"] = _iTemsUpdate.text;
            update[@"des"] = _DesUpdate.text;
            update[@"video"] = videoGame;
            [update saveInBackground];
            [self success];
            [self getTheData];
        }
    }];
    }
}

-(void)getTheData {
    PFQuery *queryGet = [PFQuery queryWithClassName:Country];
    
    [queryGet getObjectInBackgroundWithId:_objectIdLike block:^(PFObject *objectGet, NSError *error) {
        if (!error) {
            NSString *getTitle = [objectGet objectForKey:@"NameGame"];
            NSString *getNameAndTitle = [NSString stringWithFormat:@"Your editing the game %@", getTitle];
            _LabelTitleGame.text = getNameAndTitle;
            
            _NameOFGAMEUpdate = [objectGet objectForKey:@"NameGame"];
            _iTemsUpdate = [objectGet objectForKey:@"item"];
            _DesUpdate = [objectGet objectForKey:@"des"];
        }
    }];
}

-(void)success {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Done" message:@"Your game has been updated" delegate:self cancelButtonTitle:@"Great" otherButtonTitles:nil, nil];
    [alert show];
}

- (IBAction)done:(id)sender {
    self.editTheView.hidden = YES;
}
@end
