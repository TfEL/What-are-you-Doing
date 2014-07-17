//
//  AdvancedSettingsViewController.m
//  What Are You Doing
//
//  Created by Aidan Cornelius-Bell on 17/07/2014.
//  Copyright (c) 2014 Department for Education and Child Development. All rights reserved.
//

#import "AdvancedSettingsViewController.h"

#import "AppDelegate.h"

#define AppDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

@interface AdvancedSettingsViewController ()

@end

@implementation AdvancedSettingsViewController
@synthesize resetAllSettingsOutlet, showGuideNextOutlet, changeAPIButtonOutlet;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[resetAllSettingsOutlet layer] setCornerRadius:8.0f];
    [[resetAllSettingsOutlet layer] setMasksToBounds:YES];
    [[resetAllSettingsOutlet layer] setBorderColor:[UIColor orangeColor].CGColor];
    [[resetAllSettingsOutlet layer] setBackgroundColor:[UIColor whiteColor].CGColor];
    [[resetAllSettingsOutlet layer] setBorderWidth:1.0f];
    
    [[showGuideNextOutlet layer] setCornerRadius:8.0f];
    [[showGuideNextOutlet layer] setMasksToBounds:YES];
    [[showGuideNextOutlet layer] setBorderColor:[UIColor orangeColor].CGColor];
    [[showGuideNextOutlet layer] setBackgroundColor:[UIColor whiteColor].CGColor];
    [[showGuideNextOutlet layer] setBorderWidth:1.0f];
    
    [[changeAPIButtonOutlet layer] setCornerRadius:8.0f];
    [[changeAPIButtonOutlet layer] setMasksToBounds:YES];
    [[changeAPIButtonOutlet layer] setBorderColor:[UIColor orangeColor].CGColor];
    [[changeAPIButtonOutlet layer] setBackgroundColor:[UIColor whiteColor].CGColor];
    [[changeAPIButtonOutlet layer] setBorderWidth:1.0f];
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

- (IBAction)changeAPIButtonPress:(id)sender {
    [[[UIAlertView alloc] initWithTitle:@"Communication Error"
                                message:@"No API found."
                               delegate:nil
                      cancelButtonTitle:@"Try again"
                      otherButtonTitles:nil] show];
}

- (IBAction)resetAllSettingsPress:(id)sender {
    AppDelegate.setupCompleted = @"no";
    
    NSUserDefaults *defs = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *dict = [defs dictionaryRepresentation];
    
    for (id key in dict) {
        [AppDelegate.userDefaults removeObjectForKey:key];
    }
    [defs synchronize];
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"homeView"];
    [self presentViewController:vc animated:NO completion:nil];
}

- (IBAction)showGuideNextPress:(id)sender {
}
@end
