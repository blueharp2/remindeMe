//
//  DetailViewController.m
//  remindMe
//
//  Created by Lindsey on 11/24/15.
//  Copyright © 2015 Lindsey Boggio. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end
@implementation DetailViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    NSLog(@"@", self.annotationTitle);
    NSLog(@"%f %f", self.coordinate.latitude, self.coordinate.longitude);
}

@end
