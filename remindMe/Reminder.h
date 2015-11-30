//
//  Reminder.h
//  remindMe
//
//  Created by Lindsey on 11/25/15.
//  Copyright © 2015 Lindsey Boggio. All rights reserved.
//

#import <Foundation/Foundation.h>
@import Parse;

@interface Reminder : PFObject <PFSubclassing>

@property (copy, nonatomic) NSString *reminder;
@property (strong, nonatomic)PFGeoPoint *location;
@property (strong, nonatomic) NSNumber *radius;

@end
