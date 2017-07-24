//
//  FourViewController.m
//  Scout Games
//
//  Created by Alex Stubbs on 18/03/2015.
//  Copyright (c) 2015 Alex Stubbs. All rights reserved.
//

#import "FourViewController.h"

@interface FourViewController ()

@end

@implementation FourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    cellTitles = @[@"User Info", @"My Games", @"Feedback", @"Remove Ads", @"World Games"];
    self.table.backgroundColor = [UIColor colorWithRed:238/255.0f green:238/255.0f blue:238/255.0f alpha:1];
    self.view.backgroundColor = [UIColor colorWithRed:238/255.0f green:238/255.0f blue:238/255.0f alpha:1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [cellTitles count];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setBackgroundColor:[UIColor clearColor]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"firstOne";

    
   TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.cellTitle.text = [cellTitles objectAtIndex:indexPath.row];
    cell.backgroundColor = [UIColor colorWithRed:238/255.0f green:238/255.0f blue:238/255.0f alpha:1];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        [self userInfo];
        NSLog(@"index = 0");
    }else if (indexPath.row == 1) {
        [self myGames];
        NSLog(@"index = 1");
    }else if (indexPath.row == 2) {
        [self Feedbacks];
        NSLog(@"index = 2");
    }else if (indexPath.row == 3) {
        [self RemoveAds];
        NSLog(@"index = 3");
    }else if (indexPath.row == 4) {
        [self worldGames];
        NSLog(@"index = 4");
    }
    

}


-(void)userInfo {
    [self performSegueWithIdentifier:@"UserInfo" sender:self];
}


-(void)myGames {
    [self performSegueWithIdentifier:@"My Games" sender:self];
}

-(void)Feedbacks {
    [self performSegueWithIdentifier:@"Feedback" sender:self];
}

-(void)RemoveAds {
    [self performSegueWithIdentifier:@"Store" sender:self];
}

-(void)worldGames {
    [self performSegueWithIdentifier:@"Games" sender:self];
}

@end
