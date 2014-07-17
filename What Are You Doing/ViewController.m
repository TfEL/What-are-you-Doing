//
//  ViewController.m
//  What Are You Doing
//
//  Created by Aidan Cornelius-Bell on 3/07/2014.
//  Copyright (c) 2014 Department for Education and Child Development. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"

#define AppDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

@interface ViewController ()

@end

@implementation ViewController

@synthesize studentButton, teacherButton, teachMeOutlet, startHereText;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [[studentButton layer] setCornerRadius:8.0f];
    [[studentButton layer] setMasksToBounds:YES];
    [[studentButton layer] setBorderColor:[UIColor orangeColor].CGColor];
    [[studentButton layer] setBorderWidth:2.0f];
    
    [[teacherButton layer] setCornerRadius:8.0f];
    [[teacherButton layer] setMasksToBounds:YES];
    [[teacherButton layer] setBorderColor:[UIColor orangeColor].CGColor];
    [[teacherButton layer] setBorderWidth:2.0f];
    
    [[teachMeOutlet layer] setCornerRadius:8.0f];
    [[teachMeOutlet layer] setMasksToBounds:YES];
    [[teachMeOutlet layer] setBorderColor:[UIColor orangeColor].CGColor];
    [[teachMeOutlet layer] setBorderWidth:2.0f];
    
    if ([AppDelegate.setupCompleted isEqualToString:@"no"]) {
        studentButton.hidden = true;
        startHereText.hidden = false;
    } else {
        studentButton.hidden = false;
        startHereText.hidden = true;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)exitLessonPress:(id)sender {
    // Do synchronisation
}
@end
