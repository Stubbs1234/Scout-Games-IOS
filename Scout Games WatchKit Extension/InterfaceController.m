//
//  InterfaceController.m
//  Scout Games WatchKit Extension
//
//  Created by Alex Stubbs on 29/04/2015.
//  Copyright (c) 2015 Alex Stubbs. All rights reserved.
//

#import "InterfaceController.h"


@interface InterfaceController()

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    // Configure interface objects here.
}


- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    
    if ([WKInterfaceDevice currentDevice].screenBounds.size.width == 136.0f) {
        _device = @"AppleWatch Connected";
    }
    else if ([WKInterfaceDevice currentDevice].screenBounds.size.width == 400.0f) {
        _device = @"AppleWatch Connected";
    }
    else {
        _device = @"No AppleWatch";
    }
    
    NSUserDefaults *AppleWatchFound = [[NSUserDefaults alloc] initWithSuiteName:@"group.appleWatchFound"];
    [AppleWatchFound setObject:_device forKey:@"foundAnAppleWatch"];
    [AppleWatchFound synchronize];
    

}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end



