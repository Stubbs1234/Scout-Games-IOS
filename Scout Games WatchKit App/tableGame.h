//
//  tableGame.h
//  Scout Games
//
//  Created by Alex Stubbs7 on 21/05/2015.
//  Copyright (c) 2015 Alex Stubbs. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>
#import "WatchCell.h"
#import <Parse/Parse.h>

@interface tableGame : WKInterfaceController
@property (nonatomic, strong) NSArray *gamesArray;
@property (nonatomic, strong) IBOutlet WKInterfaceTable *gamesTable;
@end
