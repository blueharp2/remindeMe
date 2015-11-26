//
//  Reminder.m
//  remindMe
//
//  Created by Lindsey on 11/25/15.
//  Copyright © 2015 Lindsey Boggio. All rights reserved.
//

#import "Reminder.h"

@implementation Reminder

@dynamic reminder;
@dynamic location;
@dynamic radius;

+(void) load {
    [self registerSubclass];
}

+(NSString *)parseClassName {
    return @"Reminder";
}

@end
