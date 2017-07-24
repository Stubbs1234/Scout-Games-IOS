//
//  tableGame.m
//  Scout Games
//
//  Created by Alex Stubbs7 on 21/05/2015.
//  Copyright (c) 2015 Alex Stubbs. All rights reserved.
//

#import "tableGame.h"

@interface tableGame ()

@end

@implementation tableGame
@synthesize gamesArray;
- (instancetype)init {
    
    self = [super init];
    if (self) {
    }
    return self;
}



- (void)willActivate {
    
    NSLog(@"%@ will activate", self);
    [self TableData];
}



- (void)didDeactivate {
    
    NSLog(@"%@ did deactivate", self);
    
}

- (void)TableData {
    NSUserDefaults *getTableArray = [[NSUserDefaults alloc] initWithSuiteName:@"group.scoutgamestable"];
    [getTableArray synchronize];
    gamesArray = [getTableArray arrayForKey:@"getTableArray"];
    
    if (gamesArray) {
        NSLog(@"Array Full %@", gamesArray);
    } else {
        NSLog(@"NOt Full");
    }
        [self.gamesTable setNumberOfRows:self.gamesArray.count withRowType:@"TableForFavs"];
        
        [self.gamesArray enumerateObjectsUsingBlock:^(NSString *NameGame, NSUInteger idx, BOOL *stop) {
            
            WatchCell *row = [self.gamesTable rowControllerAtIndex:idx];
            
            [row.cellTitle setText:NameGame];
            
            
            
        }];
    }

- (void)table:(WKInterfaceTable *)table didSelectRowAtIndex:(NSInteger)rowIndex {
    
    NSArray *newCityNames = @[@"This works"];
    
    
    
    NSIndexSet *newCityIndexes = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(rowIndex + 1, newCityNames.count)];

    
    [self.gamesTable insertRowsAtIndexes:newCityIndexes withRowType:@"TableForFavs"];
    
    __block NSInteger newCityNumber = 0;
    
    [newCityIndexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
        
        NSString *newCityName = newCityNames[newCityNumber];
        
        
        
        WatchCell *row = [self.gamesTable rowControllerAtIndex:idx];
        
        
        
        [row.cellTitle setText:newCityName];
        
        
        
        newCityNumber++;
        
    }];
    
}

/*-(void)handoff {
    NSUserActivity* myActivity = [[NSUserActivity alloc]
                                  initWithActivityType: @"com.myCompany.myBrowser.browsing"];
    myActivity.userInfo = @{};
    myActivity.title = @"Browsing";
    [myActivity becomeCurrent];
}*/


@end



