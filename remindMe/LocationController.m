//
//  LocationController.m
//  remindMe
//
//  Created by Lindsey on 11/24/15.
//  Copyright © 2015 Lindsey Boggio. All rights reserved.
//

#import "LocationController.h"

@interface LocationController() <CLLocationManagerDelegate>

@end


@implementation LocationController

+(LocationController *) sharedController{
    static LocationController *sharedController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedController = [[self alloc]init];
    });
    return sharedController;
}

-(id)init {
    self = [super init];
    if (self){
        _locationManager = [[CLLocationManager alloc]init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = 100;
        
        [_locationManager requestWhenInUseAuthorization];
    }
    return self;
}

#pragma mark LocationController

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    [self.delegate locationControllerDidUpdateLocation:locations.lastObject];
    [self setLocation:locations.lastObject];
}

@end
