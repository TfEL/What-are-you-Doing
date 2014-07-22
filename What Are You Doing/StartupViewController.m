//
//  StartupViewController.m
//  What Are You Doing
//
//  Created by Aidan Cornelius-Bell on 21/07/2014.
//  Copyright (c) 2014 Department for Education and Child Development. All rights reserved.
//

#import "StartupViewController.h"

#import "AppDelegate.h"

#define AppDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

@interface StartupViewController ()

@end

@implementation StartupViewController

@synthesize setupButtonOutlet, resumeButtonOutlet, startHereOutlet;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[setupButtonOutlet layer] setCornerRadius:8.0f];
    [[setupButtonOutlet layer] setMasksToBounds:YES];
    [[setupButtonOutlet layer] setBorderColor:[UIColor colorWithRed:(128/255.0) green:(202/255.0) blue:(201/255.0) alpha:1].CGColor];
    [[setupButtonOutlet layer] setBorderWidth:2.0f];
    
    [[resumeButtonOutlet layer] setCornerRadius:8.0f];
    [[resumeButtonOutlet layer] setMasksToBounds:YES];
    [[resumeButtonOutlet layer] setBorderColor:[UIColor colorWithRed:(128/255.0) green:(202/255.0) blue:(201/255.0) alpha:1].CGColor];
    [[resumeButtonOutlet layer] setBorderWidth:2.0f];
    
    if ([AppDelegate.setupCompleted isEqualToString:@"no"]) {
        resumeButtonOutlet.hidden = true;
        startHereOutlet.hidden = false;
    } else {
        resumeButtonOutlet.hidden = false;
        startHereOutlet.hidden = true;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
