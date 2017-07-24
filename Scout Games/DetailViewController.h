//
//  DetailViewController.h
//  Scout Games
//
//  Created by Alex Stubbs7 on 09/02/2016.
//  Copyright © 2016 Alex Stubbs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "database.h"
#import "HomeModel.h"
@interface DetailViewController : UIViewController

@property (strong, nonatomic) database *selectedwalk;

@property (weak, nonatomic) IBOutlet UILabel *walkLabel;

@property (weak, nonatomic) IBOutlet UILabel *milesLabel;

@property (strong, nonatomic) NSDictionary *jsonElement;
@property(nonatomic, retain) IBOutlet UITextView *details;
@property (strong, nonatomic) IBOutlet UILabel *area;
@property (strong, nonatomic) IBOutlet UILabel *noWatch;
@property (strong, nonatomic) IBOutlet UIButton *showWatch;
@property (strong, nonatomic) IBOutlet UILabel *longitude;
@property (strong, nonatomic) IBOutlet UILabel *latitude;
@property (strong, nonatomic) NSString *myString;
@property (strong, nonatomic) NSString *myString1;

@end
