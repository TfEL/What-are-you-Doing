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
    NSUInteger lastTimer;
    
    NSString *theTimerName;
    
    lastTimer = [AppDelegate.userDefaults integerForKey:@"lastTimerPassed"];
    
    // Figure out which timer to run – this is NOT intelligent, and needs some work
    
    if (lastTimer == 0) {
        theTimer = [AppDelegate.userDefaults objectForKey:@"TimerOne"];
        theTimerName = @"Timer One";
    } else if (lastTimer == 1) {
        theTimer = [AppDelegate.userDefaults objectForKey:@"TimerTwo"];
        theTimerName = @"Timer Two";
    } else if (lastTimer == 2) {
        theTimer = [AppDelegate.userDefaults objectForKey:@"TimerThree"];
        theTimerName = @"Timer Three";
    } else if (lastTimer == 3) {
        theTimer = [AppDelegate.userDefaults objectForKey:@"TimerFour"];
        theTimerName = @"Timer Four";
    } else if (lastTimer == 4) {
        theTimer = [AppDelegate.userDefaults objectForKey:@"TimerFive"];
        theTimerName = @"Timer Five";
    } else if (lastTimer == 5) {
        theTimer = [AppDelegate.userDefaults objectForKey:@"TimerSix"];
        theTimerName = @"Timer Six";
    } else if (lastTimer == 6) {
        theTimer = [AppDelegate.userDefaults objectForKey:@"TimerSeven"];
        theTimerName = @"Timer Seven";
    } else if (lastTimer == 7) {
        theTimer = [AppDelegate.userDefaults objectForKey:@"TimerEight"];
        theTimerName = @"Timer Eight";
    } else if (lastTimer == 8) {
        theTimer = [AppDelegate.userDefaults objectForKey:@"TimerNine"];
        theTimerName = @"Timer Nine";
    } else if (lastTimer == 9) {
        theTimer = [AppDelegate.userDefaults objectForKey:@"TimerTen"];
        theTimerName = @"Timer Ten";
    } else {
        UIAlertView *error = [[UIAlertView init]  initWithTitle:@"Uh oh!" message:@"There are no timers in the future, your teacher might need to set up this iPad again." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles: nil];
        [error show];
    }
    
    NSLog(@"%@", theTimerName);
    
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
    dateFormatter.DateFormat = @"yyyy-MM-dd HH:mm:ss";
    dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"Adelaide/Australia"];
    
    futureDate = [dateFormatter dateFromString:futureDateString];
    
    rightNowString = [dateFormatter stringFromDate:nowDate];
    
    nowDate = [dateFormatter dateFromString:rightNowString];
    
    long elapsedSeconds = [futureDate timeIntervalSinceDate:nowDate];
    
    NSLog(@"Received new compare, %@ : %@. Handing back %ld seconds.", futureDate, nowDate, elapsedSeconds);
    
    // View has loaded, but it hasn't UNLOADED
    AppDelegate.countdownViewHasLoaded = (bool*)YES;
    AppDelegate.countdownViewHasUnloaded = (bool *)NO;
    
    return elapsedSeconds;
}

-(NSDate*)compareTimeUntilTimerWithDate:(NSString*)dateIn {
    NSString *futureDateString;
    
    futureDateString = dateIn;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.DateFormat = @"yyyy-MM-dd HH:mm:ss";
    dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"Adelaide/Australia"];
    
    return [dateFormatter dateFromString:futureDateString];
}

- (void)updateCounter: (NSTimer *)timerData {
    NSString *theTimer = [self whichTimerShouldIUse];
    secondsLeft = [self compareTimeUntilTimer:theTimer];

    secondsLeft -- ;
    hours = secondsLeft / 3600;
    minutes = (secondsLeft % 3600) / 60;
    seconds = (secondsLeft %3600) % 60;
    countDownLabel.text = [NSString stringWithFormat:@"Unlocks in %02d:%02d", minutes, seconds];
}

-(void)countdownTimer {
    secondsLeft = hours = minutes = seconds = 0;
    if([timer isValid]) { }
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateCounter:) userInfo:nil repeats:YES];
    
    /* NSLog(@"Reached 0");
    touched ++;
    if (touched == 2) {
        NSLog(@"..");
        [timer fire];
    } else {
        secondsLeft = [self compareTimeUntilTimer:theTimer];
    } */
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
    
    NSDate *theTimerAsDate = [self compareTimeUntilTimerWithDate:theTimer];
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = theTimerAsDate;
    localNotification.alertBody = [NSString stringWithFormat:@"Time to take a survey. Touch here to come back to What are you Doing."];
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
    // View has loaded, then been unloaded. :)
    AppDelegate.countdownViewHasLoaded = (bool*)NO;
    AppDelegate.countdownViewHasUnloaded = (bool *)YES;
    
    [timer invalidate];
    [timer fire];
}

@end
