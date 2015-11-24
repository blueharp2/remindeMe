//
//  ViewController.m
//  remindMe
//
//  Created by Lindsey on 11/23/15.
//  Copyright © 2015 Lindsey Boggio. All rights reserved.
//

#import "ViewController.h"
#import "LocationController.h"


@interface ViewController () <LocationControllerDelegate, MKMapViewDelegate>


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self requestPermissions];
    [self.mapView setShowsUserLocation:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[LocationController sharedController]setDelegate:self];
    [[[LocationController sharedController]locationManager]startUpdatingLocation];
}



//- (void)requestPermissions {
//    
//    self.locationManager = [[CLLocationManager alloc]init];
//    [self.locationManager requestWhenInUseAuthorization];
//}

-(void) setRegion:(MKCoordinateRegion) region{
    [self.mapView setRegion:region animated:(YES)];
}

- (IBAction)locationButtonSelected:(UIButton *)sender {
    
    //if (sender isKindOfClass:[UIButton class]) {
    
    NSString *buttonTitle = sender.titleLabel.text;
    
    if ([buttonTitle isEqualToString:@"Location A"]) {
        NSLog(@"Location A");
        
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(47.6276, -122.3366);//MOHI
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 500.0, 500.0);
        [self setRegion:region];
    }
    
    if ([buttonTitle isEqualToString:@"Location B"]) {
        NSLog(@"Location B");
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(47.6164, -122.3536); //SAM Olympic Sculpture Park
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 500.0, 500.0);
        [self setRegion:region];
    }
    
    if ([buttonTitle isEqualToString:@"Location C"]) {
        NSLog(@"Location C");
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(47.6204, -122.3491); //Space Needle
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 500.0, 500.0);
        [self setRegion:region];
    }
    
   // }
    
}

#pragma mark - LocationController

-(void)locationControllerDidUpdateLocation:(CLLocation *)location{
    [self setRegion: MKCoordinateRegionMakeWithDistance(location.coordinate, 500.0, 500.)];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
