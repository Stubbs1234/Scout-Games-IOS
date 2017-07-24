//
//  FourViewController.h
//  Scout Games
//
//  Created by Alex Stubbs on 18/03/2015.
//  Copyright (c) 2015 Alex Stubbs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>
#import "TableViewCell.h"

@interface FourViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSArray *cellTitles;
    NSArray *tableRows;
}

@property (strong, nonatomic) IBOutlet UITableView *table;

@end
