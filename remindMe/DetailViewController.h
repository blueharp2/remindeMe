//
//  DetailViewController.h
//  remindMe
//
//  Created by Lindsey on 11/24/15.
//  Copyright © 2015 Lindsey Boggio. All rights reserved.
//

#import <Foundation/Foundation.h>

@import UIKit;
@import MapKit;

typedef void (^DetailViewControllerCompletion) (MKCircle *circle);

@interface DetailViewController : UIViewController

@property (copy, nonatomic) DetailViewControllerCompletion completion;

@property (strong, nonatomic) NSString *annotationTitle;
@property (nonatomic) CLLocationCoordinate2D coordinate;

@end

