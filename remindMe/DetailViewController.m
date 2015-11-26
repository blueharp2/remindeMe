//
//  DetailViewController.m
//  remindMe
//
//  Created by Lindsey on 11/24/15.
//  Copyright © 2015 Lindsey Boggio. All rights reserved.
//

#import "DetailViewController.h"

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
}
@end
