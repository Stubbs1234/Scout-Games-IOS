//
//  WatchCell.h
//  Scout Games
//
//  Created by Alex Stubbs7 on 21/05/2015.
//  Copyright (c) 2015 Alex Stubbs. All rights reserved.
//
#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>

@interface WatchCell : NSObject
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *cellTitle;
@end
