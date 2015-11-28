//
//  ViewController.m
//  remindMe
//
//  Created by Lindsey on 11/23/15.
//  Copyright © 2015 Lindsey Boggio. All rights reserved.
//

#import "ViewController.h"
#import "LocationController.h"
#import "DetailViewController.h"
#import "Reminder.h"
@import Parse;
@import ParseUI;
@import MapKit;



@interface ViewController () <LocationControllerDelegate, MKMapViewDelegate, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self requestPermissions];
    [self.mapView setShowsUserLocation:YES];
    self.mapView.delegate = self;
    [self login];
    

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[LocationController sharedController]setDelegate:self];
    [[[LocationController sharedController]locationManager]startUpdatingLocation];
    [self parseQuery];
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
    
//    if (!annotationView) {
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"AnnotationView"];
        annotationView.canShowCallout = YES;
        UIButton *rightCallout = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];

                annotationView.rightCalloutAccessoryView = rightCallout;
//    }
    return annotationView;
    
}


-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *) control {
    [self performSegueWithIdentifier: @"DetailViewController" sender:view];
}
-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay{
    MKCircleRenderer *circleRenderer = [[MKCircleRenderer alloc]initWithOverlay:overlay];
    circleRenderer.strokeColor = [UIColor redColor];
    circleRenderer.fillColor = [UIColor redColor];
    circleRenderer.alpha = 0.5;
    
    return circleRenderer;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"DetailViewController"]) {
        if ([sender isKindOfClass:[MKAnnotationView class]]){
            MKAnnotationView *annotationView = (MKAnnotationView *) sender;
            DetailViewController *detailViewController = (DetailViewController *)segue.destinationViewController;
            detailViewController.annotationTitle = annotationView.annotation.title;
            detailViewController.coordinate = annotationView.annotation.coordinate;
           
            __weak typeof(self) weakSelf = self;
            
            detailViewController.completion = ^(MKCircle *circle) {
                [weakSelf.mapView removeAnnotation:annotationView.annotation];
                [weakSelf.mapView addOverlay:circle];
                
            };
        }
    }
    
}

#pragma mark -Parse Setup

-(void)login{
    if (![PFUser currentUser]){
        
        
        PFLogInViewController * loginViewController = [[PFLogInViewController alloc]init];
        [loginViewController setDelegate:self];
        
        PFSignUpViewController * signupViewController = [[PFSignUpViewController alloc] init];
        [signupViewController setDelegate:self];
        
        [loginViewController setSignUpController:signupViewController];

        
        [self presentViewController:loginViewController animated:YES completion:nil];
        
    }else{
        [self setupAdditionalUI];
    }
}


-(void)setupAdditionalUI{
    UIBarButtonItem *signOutButton = [[UIBarButtonItem alloc]initWithTitle:@"Sign Out" style:UIBarButtonItemStylePlain target:self action:@selector(signOut)];
    self.navigationItem.leftBarButtonItem = signOutButton;
}

-(void)signOut{
    
    [PFUser logOut];
    [self login];
}

#pragma mark - PFLoginViewControllerDelegate

-(void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self setupAdditionalUI];
}

#pragma mark - PFSignUpViewControllerDelegate

-(void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self setupAdditionalUI];
}

#pragma mark - Parse Query
//First Attempt at Query - Brings back objects but I am not sure how to get to the location within the Object
//-(void)parseQuery{
//    NSMutableArray *allObjects = [NSMutableArray array];
//    
//    PFQuery *query = [PFQuery queryWithClassName:@"Reminder"];
//
//    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        if (!error) {
//            NSLog(@"Received objects from Parse");
//            [allObjects addObjectsFromArray:objects];
//            
//        }else{
//            NSLog(@"Error: %@ %@, error, [error userInfo]");
//        }
//        for (int i=0; i<[allObjects count]; i++){
//            NSLog(@"%d: %@", i, allObjects[i]);
//        }
//        
//    }];
//}
//Second attempt at Querry - I'm not sure what to point nearGeoPoint at to get this to work.
-(void)parseQuery{
    NSMutableArray *allObjects = [NSMutableArray array];
    
    //This somehow works with the nearGeoPoint or at least it gets rid of the error.
    PFGeoPoint *geoPoint = [PFGeoPoint geoPointWithLatitude:37.3175 longitude:-122.0419];//Apple Headquarters
    PFObject *place = [[PFObject alloc] initWithClassName:@"Reminder"];
    place[@"location"] = geoPoint;
    
    
    
    PFQuery *query = [PFQuery queryWithClassName:@"Reminder"];
    [query whereKey:@"location" nearGeoPoint:geoPoint];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            NSLog(@"Received objects from Parse");
            [allObjects addObjectsFromArray:objects];
            
        }else{
            NSLog(@"Error: %@ %@, error, [error userInfo]");
        }
        
        
        for (int i=0; i<[allObjects count]; i++){
            NSLog(@"%d: %@", i, allObjects[i]);
            
            
            //This attempt doesn't work either
//            for (NSArray *objects in allObjects){
//                Reminder *reminder = [[Reminder alloc]init];
//                reminder.location = reminder[@"location"];
//                reminder.reminder = reminder[@"reminder"];
//                reminder.radius = reminder[@"radius"];
//            }
           
            //The parseObjects below doesn't work.
//            for (NSDictionary *parseObjects in allObjects){
//                Reminder *reminder = [[Reminder alloc] init];
//                if (self) {
//                    reminder.location = parseObjects[@"location"];
//                    reminder.reminder = parseObjects[@"reminder"];
//                    reminder.radius = parseObjects[@"raduis"];
//                }
            //}
        }
    }];
}


@end
