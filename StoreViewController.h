//
//  StoreViewController.h
//  Scout Games
//
//  Created by Alex Stubbs7 on 23/05/2015.
//  Copyright (c) 2015 Alex Stubbs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>
#import <Parse/Parse.h>

@interface StoreViewController : UIViewController <SKPaymentTransactionObserver, SKRequestDelegate, SKProductsRequestDelegate> {
    SKProductsRequest *productsRequest;
    NSArray *validProducts;
    NSString *email;
    NSString *trail1;
    NSString *tendaywarn;
    NSString *sub;
}


@property (strong, nonatomic) SKProduct *product;
@property (strong, nonatomic) IBOutlet UIButton *buyProduct;
- (void) completeTransaction: (SKPaymentTransaction *)transaction;
- (void) restoreTransaction: (SKPaymentTransaction *)transaction;
- (void) failedTransaction: (SKPaymentTransaction *)transaction;
- (IBAction)backButton:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *type;
@property (strong, nonatomic) NSString *dateString;


@end
