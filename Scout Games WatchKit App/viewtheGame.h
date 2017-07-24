//
//  viewtheGame.h
//  Scout Games
//
//  Created by Alex Stubbs7 on 21/05/2015.
//  Copyright (c) 2015 Alex Stubbs. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>

@interface viewtheGame : WKInterfaceController

@property(strong, nonatomic) IBOutlet WKInterfaceLabel *nameOfGame;
@property(strong, nonatomic) IBOutlet WKInterfaceLabel *item;
@property(strong, nonatomic) IBOutlet WKInterfaceLabel *des;
@end
