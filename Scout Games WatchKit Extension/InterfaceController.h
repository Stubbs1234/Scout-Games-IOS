//
//  InterfaceController.h
//  Scout Games WatchKit Extension
//
//  Created by Alex Stubbs on 29/04/2015.
//  Copyright (c) 2015 Alex Stubbs. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>
#import "tableGame.h"

@interface InterfaceController : WKInterfaceController {
    NSArray *passArray;
}

@property (strong, nonatomic) NSString *device;
- (IBAction)gameView;
- (IBAction)favs;


@end
