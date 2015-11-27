//
//  DetailViewController.m
//  remindMe
//
//  Created by Lindsey on 11/24/15.
//  Copyright © 2015 Lindsey Boggio. All rights reserved.
//

#import "DetailViewController.h"
#import "Reminder.h"
#import "LocationController.h"

@import Parse;
@import MapKit;

@interface DetailViewController ()


@property (weak, nonatomic) IBOutlet UITextField *reminderTextField;
@property (weak, nonatomic) IBOutlet UITextField *radiusTextField;

- (IBAction)saveReminderButton:(UIButton *)sender;

@end



@implementation DetailViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
//    NSLog(@"@", self.annotationTitle);
//    NSLog(@"%f %f", self.coordinate.latitude, self.coordinate.longitude);
}

-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.reminderTextField becomeFirstResponder];
}



- (IBAction)saveReminderButton:(UIButton *)sender {
    
    Reminder *reminder = [[Reminder alloc]init];
    reminder.reminder = self.reminderTextField.text;
    reminder.radius = [NSNumber numberWithFloat:self.radiusTextField.text.floatValue];
    reminder.location= [PFGeoPoint geoPointWithLatitude:self.coordinate.latitude longitude:self.coordinate.longitude];
    
    [reminder saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        NSLog(@"Reminder saved to Parse");
        
        if (self.completion) {
            if ([CLLocationManager isMonitoringAvailableForClass:[CLCircularRegion class]]){
                CLCircularRegion *region = [[CLCircularRegion alloc]initWithCenter:self.coordinate radius:self.radiusTextField.text.floatValue identifier:self.reminderTextField.text];
                [[[LocationController sharedController]locationManager]startMonitoringForRegion:region];
                
                self.completion([MKCircle circleWithCenterCoordinate:self.coordinate radius:self.radiusTextField.text.floatValue]);
                
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
        
    }];
}
@end
