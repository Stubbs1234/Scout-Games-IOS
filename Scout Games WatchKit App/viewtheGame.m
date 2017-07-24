//
//  viewtheGame.m
//  Scout Games
//
//  Created by Alex Stubbs7 on 21/05/2015.
//  Copyright (c) 2015 Alex Stubbs. All rights reserved.
//

#import "viewtheGame.h"

@interface viewtheGame ()

@end

@implementation viewtheGame

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    
    
    
    NSUserDefaults *mySharedDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.nameofgame"];
    [mySharedDefaults synchronize];
    self.nameOfGame.text = [mySharedDefaults stringForKey:@"savedNameOfGame"];
    
    NSUserDefaults *item = [[NSUserDefaults alloc] initWithSuiteName:@"group.item"];
    [item synchronize];
    self.item.text = [item stringForKey:@"savediTemForGame"];
    
    NSUserDefaults *des = [[NSUserDefaults alloc] initWithSuiteName:@"group.des"];
    [des synchronize];
    self.des.text = [des stringForKey:@"savedDescription"];

}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end



