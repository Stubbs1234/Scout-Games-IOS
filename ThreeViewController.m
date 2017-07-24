//
//  ThreeViewController.m
//  Scout Games
//
//  Created by Alex Stubbs on 18/03/2015.
//  Copyright (c) 2015 Alex Stubbs. All rights reserved.
//

#import "ThreeViewController.h"

@interface ThreeViewController ()

@end

@implementation ThreeViewController

#define iPhone4s ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && MAX([UIScreen mainScreen].bounds.size.height,[UIScreen mainScreen].bounds.size.width) == 480)
#define iPhone5 ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && MAX([UIScreen mainScreen].bounds.size.height,[UIScreen mainScreen].bounds.size.width) == 568)
#define iPhone5s ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && MAX([UIScreen mainScreen].bounds.size.height,[UIScreen mainScreen].bounds.size.width) == 568)
#define iPhone6 ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && MAX([UIScreen mainScreen].bounds.size.height,[UIScreen mainScreen].bounds.size.width) == 667)
#define iPhone6Plus ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && MAX([UIScreen mainScreen].bounds.size.height,[UIScreen mainScreen].bounds.size.width) == 736)

- (void)viewDidLoad {
    [super viewDidLoad];
    
        self.view.backgroundColor = [UIColor colorWithRed:238/255.0f green:238/255.0f blue:238/255.0f alpha:1];
        [[_des layer] setBorderColor:[UIColor blackColor].CGColor];
        [[_des layer] setBorderWidth:2.0];
    _Group.enabled = NO;
    
    [self performSelector:@selector(checkForUserId)];
    
}

-(void)checkForUserId {
    PFUser *user = [PFUser currentUser];
    objectId = (user.objectId);
    NSLog(@"user id %@", objectId);
    [self ParseUser];
    [self groupGrab];
}

-(void)groupGrab {
    NSLog(@"runing group");
    PFQuery *query1 = [PFQuery queryWithClassName:@"_User"];
    
    [query1 whereKey:@"objectId" equalTo:objectId];
    [query1 getFirstObjectInBackgroundWithBlock:^(PFObject *object1, NSError *error) {
        if (!error) {
        _Group.text = [object1 objectForKey:@"groupName"];
        }
    }];
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
        upload = @"ukgames";
        NSLog(@"Upload %@", upload);
    } else if ([StringCountry isEqualToString:@"Canada"]) {
        NSLog(@"can");
        upload = @"cangames";
        NSLog(@"Upload %@", upload);
    } else if ([StringCountry isEqualToString:@"United States"]) {
        NSLog(@"US");
        upload = @"usgames";
        NSLog(@"Upload %@", upload);
    } else if ([StringCountry isEqualToString:@"Australia"]) {
        NSLog(@"Aus");
        upload = @"ausgames";
        NSLog(@"Upload %@", upload);
    } else if (StringCountry !=  NULL) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Country Found" message:@"We have not been able to found an country that you are in so you have been put on the UK game list. Please update you information in your account under more" delegate:self cancelButtonTitle:@"Will Do" otherButtonTitles:nil, nil];
        [alert show];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)save:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        UIAlertView *cameraShow = [[UIAlertView alloc] initWithTitle:@"Upload Video" message:@"Would you like to upload a video with this game" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
        [cameraShow show];
        _NameOfGame.enabled = NO;
        _Needed.enabled = NO;
        _des.editable = NO;
        
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if(buttonIndex == [alertView firstOtherButtonIndex])
    {
        NSLog(@"Yes was selected.");
        [self upload];
        NSLog(@"UPload work");
    } else {
        [self noUpload];
        NSLog(@"No Video Needed");
    }
}

-(void)upload
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.delegate = self;
        picker.allowsEditing = NO;
        
        NSArray *mediaTypes = [[NSArray alloc]initWithObjects:(NSString *)kUTTypeMovie, nil];
        
        picker.mediaTypes = mediaTypes;
        
        [picker setVideoMaximumDuration:90.0f];
        
        [self presentViewController:picker animated:YES completion:NULL];
        
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
        
        [self saveVideo];
        NSLog(@"Video save for parse");
   [self dismissViewControllerAnimated:YES completion:NULL];
    }

- (NSURL*)grabFileURL:(NSString *)fileName {
    
    // find Documents directory
    NSURL *documentsURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    
    // append a file name to it
    documentsURL = [documentsURL URLByAppendingPathComponent:fileName];
    
    return documentsURL;
}

- (void)saveVideo {
    NSLog(@"saving Video");
    NSData *videoData = [NSData dataWithContentsOfURL:_videoURL];
          PFFile *videoGame = [PFFile fileWithName:@"Video.mov" data:videoData];
    
    NSLog(@"Video is ok for uplaod");
  PFObject *game = [PFObject objectWithClassName:upload];
    if (_NameOfGame.text) game[@"NameGame"] = _NameOfGame.text;
    if (_Needed.text) game[@"item"] = _Needed.text;
    if (_des.text) game[@"des"] = _des.text;
    if (_Group.text) game[@"group"] = _Group.text;
    if (videoGame) game[@"Video"] = videoGame;
    if (_user) game[@"userUpload"] = _user;
    
        [game saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                UIAlertView *done = [[UIAlertView alloc] initWithTitle:@"Done" message:@"The game as been uploaded" delegate:nil cancelButtonTitle:@"Cool" otherButtonTitles:nil, nil];
                [done show];
                [game saveEventually];
                
                _NameOfGame.enabled = YES;
                _Needed.enabled = YES;
                _des.editable = YES;
                _Group.enabled = YES;
                
            } else {
                UIAlertView *notDone = [[UIAlertView alloc] initWithTitle:@"Error" message:@"There was an error in upload the game. Please trying a again later" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [notDone show];
                
            }
        }];
    NSLog(@"Video uploaded");
}


-(void)noUpload {
    
    PFObject *game = [PFObject objectWithClassName:upload];
    if (_NameOfGame.text) game[@"NameGame"] = _NameOfGame.text;
    if (_Needed.text) game[@"item"] = _Needed.text;
    if (_des.text) game[@"des"] = _des.text;
    if (_Group.text) game[@"group"] = _Group.text;
    if (_user) game[@"userUpload"] = _user;
    
    [game saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            UIAlertView *done = [[UIAlertView alloc] initWithTitle:@"Done" message:@"The game as been uploaded" delegate:nil cancelButtonTitle:@"Cool" otherButtonTitles:nil, nil];
            [done show];
            [game saveEventually];
            
        } else {
            UIAlertView *notDone = [[UIAlertView alloc] initWithTitle:@"Error" message:@"There was an error in upload the game. Please trying a again later" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [notDone show];
        }
    }];
    
}

-(IBAction)textFieldReturn:(id)sender
{
    [sender resignFirstResponder];
}

- (IBAction)showpicker:(id)sender {
}
@end
