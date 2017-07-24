//
//  HomeModal.h
//  Scout Games
//
//  Created by Alex Stubbs7 on 09/02/2016.
//  Copyright © 2016 Alex Stubbs. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HomeModelProtocol <NSObject>

- (void)itemsDownloaded:(NSArray *)items;

@end

@interface HomeModel : NSObject <NSURLConnectionDataDelegate>

@property (nonatomic, weak) id<HomeModelProtocol> delegate;

- (void)downloadItems;


@end