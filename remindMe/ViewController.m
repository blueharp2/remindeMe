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

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

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

- (IBAction)handleLongPressGesture:(UILongPressGestureRecognizer *)sender {
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        
        CGPoint touchPoint = [sender locationInView:self.mapView];
        CLLocationCoordinate2D cordinate = [self.mapView convertPoint:touchPoint toCoordinateFromView: self.mapView];
        
        MKPointAnnotation *newPoint = [[MKPointAnnotation alloc]init];
        newPoint.coordinate = cordinate;
        newPoint.title = @"New Location";
        newPoint.subtitle = @"Hello";
        
        [self.mapView addAnnotation:newPoint];
        
        
    }
}



#pragma mark - LocationController

-(void)locationControllerDidUpdateLocation:(CLLocation *)location{
    [self setRegion: MKCoordinateRegionMakeWithDistance(location.coordinate, 500.0, 500.)];
}

#pragma mark = MKMapViewDelegate

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    //Add view
    MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"AnnotationView"];
    
    annotationView.annotation = annotation;
    
    if (!annotationView) {
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"AnnotationView"];
        
        annotationView.canShowCallout = YES;
        UIButton *rightCallout = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        annotationView.rightCalloutAccessoryView = rightCallout;
        
        return annotationView;
    } else {
        return nil;
    }
    
}
-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *) control {
    [self performSegueWithIdentifier: @"DetailViewController" sender:view];
}




@end
