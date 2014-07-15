//
//  CountdownViewController.m
//  What Are You Doing
//
//  Created by Aidan Cornelius-Bell on 11/07/2014.
//  Copyright (c) 2014 Department for Education and Child Development. All rights reserved.
//

#import "CountdownViewController.h"

#import "AppDelegate.h"

#define AppDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

@interface CountdownViewController ()

@end

@implementation CountdownViewController

@synthesize countDownLabel;

int hours, minutes, seconds;
int secondsLeft;
int touched;
int r;

int touched = 0;

-(NSString *)whichTimerShouldIUse {
    
    NSString *theTimer;
    NSString *lastTimer;
    
    lastTimer = [AppDelegate.userDefaults objectForKey:@"lastTimerPassed"];
    
    // Figure out which timer to run – this is NOT intelligent, and needs some work
    
    if ([lastTimer isEqualToString:@"0"]) {
        theTimer = [AppDelegate.userDefaults objectForKey:@"TimerOne"];
    } else if ([lastTimer isEqualToString:@"1"]) {
        theTimer = [AppDelegate.userDefaults objectForKey:@"TimerTwo"];
    } else if ([lastTimer isEqualToString:@"2"]) {
        theTimer = [AppDelegate.userDefaults objectForKey:@"TimerThree"];
    } else if ([lastTimer isEqualToString:@"3"]) {
        theTimer = [AppDelegate.userDefaults objectForKey:@"TimerFour"];
    } else if ([lastTimer isEqualToString:@"4"]) {
        theTimer = [AppDelegate.userDefaults objectForKey:@"TimerFive"];
    } else if ([lastTimer isEqualToString:@"5"]) {
        theTimer = [AppDelegate.userDefaults objectForKey:@"TimerSix"];
    } else if ([lastTimer isEqualToString:@"6"]) {
        theTimer = [AppDelegate.userDefaults objectForKey:@"TimerSeven"];
    } else if ([lastTimer isEqualToString:@"7"]) {
        theTimer = [AppDelegate.userDefaults objectForKey:@"TimerEight"];
    } else if ([lastTimer isEqualToString:@"8"]) {
        theTimer = [AppDelegate.userDefaults objectForKey:@"TimerNine"];
    } else if ([lastTimer isEqualToString:@"9"]) {
        theTimer = [AppDelegate.userDefaults objectForKey:@"TimerTen"];
    } else {
        UIAlertView *error = [[UIAlertView init]  initWithTitle:@"Uh oh!" message:@"There are no timers in the future, your teacher might need to set up this iPad again." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles: nil];
        [error show];
    }
    
    NSLog(@"The timer being used... %@", theTimer);
    
    return theTimer;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(long)compareTimeUntilTimer:(NSString*)dateIn {
    NSDate *nowDate, *futureDate;
    NSString *futureDateString, *rightNowString;
    
    futureDateString = dateIn;
    
    nowDate = [NSDate date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.DateFormat = @"yyyy-MM-dd HH:mm:ss Z";
    dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"Adelaide/Australia"];
    futureDate = [dateFormatter dateFromString:futureDateString];
    
    rightNowString = [dateFormatter stringFromDate:nowDate];
    nowDate = [dateFormatter dateFromString:rightNowString];
    
    long elapsedSeconds = [futureDate timeIntervalSinceDate:nowDate];
    
    // NSInteger seconds = elapsedSeconds % 60;
    // NSInteger minutes = (elapsedSeconds / 60) % 60;
    // NSInteger hours = elapsedSeconds / (60 * 60);
    
    // NSString *result= [NSString stringWithFormat:@"%02ld:%02ld:%02ld", (long)hours, (long)minutes, (long)seconds];

    return elapsedSeconds;
}

-(NSDate*)compareTimeUntilTimerWithDate:(NSString*)dateIn {
    NSString *futureDateString;
    
    futureDateString = dateIn;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.DateFormat = @"yyyy-MM-dd HH:mm:ss Z";
    dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"Adelaide/Australia"];
    
    return [dateFormatter dateFromString:futureDateString];
}

- (void)updateCounter:(NSString *)theTimer {

    NSLog(@"I'm about to die ungracefully. %@", theTimer);
    
    if(secondsLeft > 0 ){
        secondsLeft -- ;
        hours = secondsLeft / 3600;
        minutes = (secondsLeft % 3600) / 60;
        seconds = (secondsLeft %3600) % 60;
        countDownLabel.text = [NSString stringWithFormat:@"Unlocks in %02d:%02d", minutes, seconds];
    }
    else{
        NSLog(@"Reached 0");
        touched ++;
        if (touched == 2) {
            NSLog(@"..");
            [timer fire];
        } else {
            secondsLeft = [self compareTimeUntilTimer:theTimer];
        }
    }
}

-(void)countdownTimer{
    NSString *theTimer = [self whichTimerShouldIUse];
    
    secondsLeft = hours = minutes = seconds = 0;
    if([timer isValid]) { }
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateCounter:) userInfo:theTimer repeats:YES];
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    [self countdownTimer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated {
    
    NSString *theTimer = [self whichTimerShouldIUse];
    
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = [self compareTimeUntilTimerWithDate:theTimer];
    localNotification.alertBody = [NSString stringWithFormat:@"Time to take a survey. Touch here to come back to What are you Doing."];
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    [timer fire];
}

@end
