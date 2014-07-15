//
//  TimerUnlockViewController.m
//  What Are You Doing
//
//  Created by Aidan Cornelius-Bell on 8/07/2014.
//  Copyright (c) 2014 Department for Education and Child Development. All rights reserved.
//

#import "TimerUnlockViewController.h"
#include <stdlib.h>

@interface TimerUnlockViewController ()

@end

@implementation TimerUnlockViewController
@synthesize whatAreYouDoingButtonOutlet, unlockTimerOutlet, spinnerOutlet;

int hours, minutes, seconds;
int secondsLeft;
int touched;
int r;

int touched = 0;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    unlockTimerOutlet.text = @"Please wait...";
    
    [[whatAreYouDoingButtonOutlet layer] setCornerRadius:8.0f];
    [[whatAreYouDoingButtonOutlet layer] setMasksToBounds:YES];
    [[whatAreYouDoingButtonOutlet layer] setBorderColor:[UIColor orangeColor].CGColor];
    [[whatAreYouDoingButtonOutlet layer] setBorderWidth:2.0f];
    
    r = arc4random_uniform(174);
    
    NSLog(@"%02d", r);
    
    secondsLeft = r;
    
    whatAreYouDoingButtonOutlet.hidden = true;
    
    [self countdownTimer];
    
}

- (void)updateCounter:(NSTimer *)theTimer {
    if(secondsLeft > 0 ){
        secondsLeft -- ;
        hours = secondsLeft / 3600;
        minutes = (secondsLeft % 3600) / 60;
        seconds = (secondsLeft %3600) % 60;
        unlockTimerOutlet.text = [NSString stringWithFormat:@"Unlocks in %02d:%02d", minutes, seconds];
    }
    else{
        NSLog(@"Reached 0");
        touched ++;
        if (touched == 2) {
            unlockTimerOutlet.hidden = true;
            whatAreYouDoingButtonOutlet.hidden = false;
            spinnerOutlet.hidden = true;
            [timer fire];
        } else {
            secondsLeft = r;
        }
    }
}

-(void)countdownTimer{
    
    secondsLeft = hours = minutes = seconds = 0;
    if([timer isValid]) { }
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateCounter:) userInfo:nil repeats:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)whatAreYouDoingButtonPress:(id)sender {
    NSLog(@"Has unlocked, and student has started..");
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"surveyView"];
    [self presentViewController:vc animated:NO completion:nil];
}
@end
