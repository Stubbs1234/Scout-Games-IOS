//
//  DetailViewController.m
//  Scout Games
//
//  Created by Alex Stubbs7 on 09/02/2016.
//  Copyright © 2016 Alex Stubbs. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _walkLabel.text =_selectedwalk.NameGame;
    _milesLabel.text =_selectedwalk.des;
    //_area.text = _selectedwalk.area;
    //_details.text = _selectedwalk.details;
    
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
    
    
#define iPhone6 ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && MAX([UIScreen mainScreen].bounds.size.height,[UIScreen mainScreen].bounds.size.width) == 667)
#define iPhone6Plus ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && MAX([UIScreen mainScreen].bounds.size.height,[UIScreen mainScreen].bounds.size.width) == 736)
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)showWatch:(id)sender{
    
    
    
    //self.latitude.text = _myString1;
    
    NSString* myString;
    self.walkLabel.text = _myString;
    NSUserDefaults *mySharedDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.sharingformaps"];
    [mySharedDefaults setObject:myString forKey:@"savedUserInput"];
    [mySharedDefaults synchronize];
    
}

/*- (void)viewDidAppear:(BOOL)animated
 {
 
 // Create coordinates from location lat/long
 CLLocationCoordinate2D poiCoodinates;
 poiCoodinates.latitude = [self.selectedwalk.latitude doubleValue];
 poiCoodinates.longitude= [self.selectedwalk.longitude doubleValue];
 
 // Zoom to region
 MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(poiCoodinates, 750, 750);
 
 [self.mapView setRegion:viewRegion animated:YES];
 
 // Plot pin
 MKPointAnnotation *pin = [[MKPointAnnotation alloc] init];
 pin.coordinate = poiCoodinates;
 [self.mapView addAnnotation:pin];
 
 }*/
@end

