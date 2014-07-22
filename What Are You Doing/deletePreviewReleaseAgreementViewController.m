//
//  deletePreviewReleaseAgreementViewController.m
//  What Are You Doing
//
//  Created by Aidan Cornelius-Bell on 22/07/2014.
//  Copyright (c) 2014 Department for Education and Child Development. All rights reserved.
//

#import "deletePreviewReleaseAgreementViewController.h"

#import "AppDelegate.h"

#define AppDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

@interface deletePreviewReleaseAgreementViewController ()

@end

@implementation deletePreviewReleaseAgreementViewController
@synthesize agreeButtonOutlet;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[agreeButtonOutlet layer] setCornerRadius:8.0f];
    [[agreeButtonOutlet layer] setMasksToBounds:YES];
    [[agreeButtonOutlet layer] setBorderColor:[UIColor colorWithRed:(128/255.0) green:(202/255.0) blue:(201/255.0) alpha:1].CGColor];
    [[agreeButtonOutlet layer] setBackgroundColor:[UIColor whiteColor].CGColor];
    [[agreeButtonOutlet layer] setBorderWidth:1.0f];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)agreeButton:(id)sender {
    AppDelegate.hasAgreed = (bool*)true;
}
@end
