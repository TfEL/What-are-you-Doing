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

@synthesize padlockButtonOutlet, studentButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [[studentButton layer] setCornerRadius:8.0f];
    [[studentButton layer] setMasksToBounds:YES];
    [[studentButton layer] setBorderColor:[UIColor colorWithRed:(128/255.0) green:(202/255.0) blue:(201/255.0) alpha:1].CGColor];
    [[studentButton layer] setBorderWidth:2.0f];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)padlockButton:(id)sender {
   /*  if (AppDelegate.isLocked == (bool*)true) {
        AppDelegate.isLocked = (bool*)false;
        teacherButton.enabled = true;
        teacherButton.hidden = false;
    } else {
        AppDelegate.isLocked = (bool*)true;
        teacherButton.enabled = false;
        teacherButton.hidden = true;
    } */
}
@end
