//
//  StoreViewController.m
//  Scout Games
//
//  Created by Alex Stubbs7 on 23/05/2015.
//  Copyright (c) 2015 Alex Stubbs. All rights reserved.
//

#import "StoreViewController.h"

@interface StoreViewController ()

@end

@implementation StoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self performSelector:@selector(workout)];
    self.view.backgroundColor = [UIColor colorWithRed:238/255.0f green:238/255.0f blue:238/255.0f alpha:1];
    NSUserDefaults *getDefults = [NSUserDefaults standardUserDefaults];
    NSString *gotDate = [getDefults objectForKey:@"date"];
    
    if (getDefults == NULL) {
        _dateLabel.text = @"No Subscription found";
    } else {
        _dateLabel.text = gotDate;
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)buyProduct:(id)sender {
    SKProductsRequest *request= [[SKProductsRequest alloc]
                                 initWithProductIdentifiers: [NSSet setWithObject: @"com.alex.Scout_Games.Subscript"]];
    
    request.delegate = self;
    [request start];
    NSLog(@"runing buy list");
    
}

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    
    NSArray *products = response.products;
    if (products.count != 0) {
        _product = products[0];
        NSString *ProductTitle = _product.localizedTitle;
        NSString *ProductDescription = _product.localizedDescription;
        NSString *AlertStringTitle = [NSString stringWithFormat:@"Would you like to subscribe to %@", ProductTitle];
        NSString *AlertStringDescription = [NSString stringWithFormat:@"%@", ProductDescription];
        
        UIAlertView *alertIf = [[UIAlertView alloc] initWithTitle:AlertStringTitle message:AlertStringDescription delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
        [alertIf show];
        
        
        
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Product Found" message:@"Sorry no product found" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    products = response.invalidProductIdentifiers;
    for (SKProduct *product in products) {
        NSLog(@"Product Not Found %@", product);
    }
    NSLog(@"runing but list next step");
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if(buttonIndex == [alertView firstOtherButtonIndex])
    {
        NSLog(@"Yes was selected.");
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
        SKPayment *payment = [SKPayment paymentWithProduct:_product];
        [[SKPaymentQueue defaultQueue] addPayment:payment];
    }
}

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    NSLog(@"Hi Work");
    for (SKPaymentTransaction *transaction in transactions)
    {
        switch (transaction.transactionState)
        {
            case SKPaymentTransactionStatePurchased:
                [self completeTransaction:transaction];
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed:
                [self failedTransaction:transaction];
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                break;
            case SKPaymentTransactionStateRestored:
                [self restoreTransaction:transaction];
            default:
                break;
        }
    }
}

- (void) completeTransaction: (SKPaymentTransaction *)transaction
{
    NSLog(@"Transaction Completed");
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Finish!" message:@"Thanks you subscription will be one year" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
    [self dateAYear];
    [self deleteTrail];
    
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}

- (void) restoreTransaction: (SKPaymentTransaction *)transaction
{
    NSLog(@"Transaction Restored");
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}

- (void) failedTransaction: (SKPaymentTransaction *)transaction
{
    if (transaction.error.code != SKErrorPaymentCancelled)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Purchase Unsuccessful"
                                                        message:@"Your purchase failed. Please try again."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}

- (IBAction)backButton:(id)sender {
  [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void)dateAYear {
   
    NSDate *todaysDate = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setYear:1];
    NSDate *targetDate = [gregorian dateByAddingComponents:dateComponents toDate:todaysDate  options:0];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    _dateString = [dateFormatter stringFromDate:targetDate];
    [_dateLabel setText:_dateString];
    NSLog(@"A year on %@", _dateString);
    
    NSUserDefaults *defults = [NSUserDefaults standardUserDefaults];
    [defults setObject:_dateString forKey:@"date"];
    [defults synchronize];
    
    [self uploadToParse];
}

-(void)uploadToParse {
    NSString *objectId;
    PFUser *user = [PFUser currentUser];
    objectId = (user.objectId);
    NSLog(@"user id %@", objectId);
    
    NSString *message = [NSString stringWithFormat:@"Your renewal of subscription is %@", _dateString];
    
    PFQuery *query = [PFQuery queryWithClassName:@"_User"];
    
    [query getObjectInBackgroundWithId:objectId block:^(PFObject *object, NSError *error) {
        if (!error) {
            object[@"renewDate"] = _dateString;
            object[@"webServerDate"] = _dateString;
            object[@"sub"] = @YES;
            [object saveEventually];
            UIAlertView *done = [[UIAlertView alloc] initWithTitle:@"Thank You" message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [done show];
            [self deleteTrail];
            
        } else {
            UIAlertView *notDone = [[UIAlertView alloc] initWithTitle:@"Error" message:@"There was an error. Please trying a again later" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [notDone show];
        }
    }];
}

-(void)deleteTrail {
        
    PFQuery *query = [PFQuery queryWithClassName:@"_User"];
    [query getObjectInBackgroundWithId:[PFUser currentUser].objectId
                                 block:^(PFObject *objectUpdate, NSError *error) {
                                     objectUpdate[@"trial"] = @NO;
                                     objectUpdate[@"tenOn"] = @NO;
                                     [objectUpdate saveEventually];
                                 }];
    
    [self emailsubscript];
    
}

-(void)emailsubscript {
    [PFCloud callFunction:@"sub" withParameters:@{@"email": email}];
}

-(void)workout {
    PFQuery *queryWorkOut = [PFQuery queryWithClassName:@""];
    [queryWorkOut whereKey:@"objectId" equalTo:[PFUser currentUser].objectId];
    [queryWorkOut getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error){
        trail1 = [object objectForKey:@"trial"];
        tendaywarn = [object objectForKey:@"tenOn"];
        sub = [object objectForKey:@"sub"];
        [self workout2];
    }];
}

-(void)workout2 {
    
    if ([trail1 boolValue] == 1) {
        
        _type.text = @"Your are on a Trial Run";
        
    } else if ([tendaywarn boolValue] == 1) {
        
        _type.text = @"Your are on a 10 Day warning and need to buy an subscriptaion";
        
    } else if ([sub boolValue] == 1) {
        
        _type.text = @"You are on a subscriptation";
        
    }else {
        
        _type.text = @"Nothing was found";
        
    }
    
}
@end