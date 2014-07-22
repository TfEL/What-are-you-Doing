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

@synthesize setupButtonOutlet, resumeButtonOutlet, startHereOutlet, endClassButtonOutlet;


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
    
    [[endClassButtonOutlet layer] setCornerRadius:8.0f];
    [[endClassButtonOutlet layer] setMasksToBounds:YES];
    [[endClassButtonOutlet layer] setBorderColor:[UIColor colorWithRed:(128/255.0) green:(202/255.0) blue:(201/255.0) alpha:1].CGColor];
    [[endClassButtonOutlet layer] setBackgroundColor:[UIColor whiteColor].CGColor];
    [[endClassButtonOutlet layer] setBorderWidth:1.0f];
    
    if ([AppDelegate.setupCompleted isEqualToString:@"no"]) {
        resumeButtonOutlet.hidden = true;
        startHereOutlet.hidden = false;
    } else {
        resumeButtonOutlet.hidden = false;
        setupButtonOutlet.hidden = true;
        endClassButtonOutlet.hidden = false;
        startHereOutlet.hidden = true;
    }
}

-(void)viewDidAppear:(BOOL)animated {
    if (AppDelegate.hasAgreed == (bool*)NO) {
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"PrereleaseAgreement"];
        [self.navigationController pushViewController:vc animated:YES];
        [self presentViewController:vc animated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)endClassButton:(id)sender {
    AppDelegate.setupCompleted = @"no";
    
    NSUserDefaults *defs = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *dict = [defs dictionaryRepresentation];
    
    for (id key in dict) {
        [AppDelegate.userDefaults removeObjectForKey:key];
    }
    [defs synchronize];
    
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"setupView"];
    [self presentViewController:vc animated:NO completion:nil];
}
@end
