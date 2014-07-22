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

@synthesize countDownLabelOutlet;

// Some local variables
int hours, minutes, seconds;
int secondsLeft;
int touched;
int r;


// Functions

// Error Message
-(void)displayComplicatedError:(NSString*)errorMessage {
    [[[UIAlertView alloc] initWithTitle:@"Timer Error"
                                message:errorMessage
                               delegate:nil
                      cancelButtonTitle:@"Try again"
                      otherButtonTitles:nil] show];
}

// Get next timer

-(NSString *)updateNextTimer {
    NSString *classCode = [AppDelegate.userDefaults objectForKey:@"classCode"];
    
    NSString *surveyCompleteEndpoint = @"nextimer_exchange.php";
    
    NSString *requestURL = [NSString stringWithFormat:@"%1@%2@?challenge=%3@", AppDelegate.apiBaseURL, surveyCompleteEndpoint, classCode];
    
    NSError *error;
    
    NSData *returnedData = [NSData dataWithContentsOfURL: [NSURL URLWithString:requestURL] options:NSDataReadingUncached error:&error];
    
    if (error) {
        [[[UIAlertView alloc] initWithTitle:@"Communication Error"
                                    message:@"App was unable to communicate with the server, is your WiFi / Mobile connected? \n\nUsing TfEL's server? Check \nhttps://status.tfel.edu.au\nif you have a connection. \n\nUsing an intranet server? Check with your network administrator."
                                   delegate:nil
                          cancelButtonTitle:@"Try again"
                          otherButtonTitles:nil] show];
    } else {
        NSLog(@"Communication Successful");
        
        if(NSClassFromString(@"NSJSONSerialization")) {
            // Setup an empty error
            NSError *error = nil;
            // Convert the data to a json object
            id object = [NSJSONSerialization JSONObjectWithData:returnedData options:0 error:&error];
            // If there was nothing, fill the error...
            if(error) {
                [self displayComplicatedError:@"No Data"];
            }
            if([object isKindOfClass:[NSDictionary class]]) {
                NSDictionary *results = object;
                NSLog(@"%@", results);
                
                NSString *returnCode = [results objectForKey:@"return"];
                
                
                if ([returnCode isEqualToString:@"fail"]) {
                    NSString *returnMessage = [results objectForKey:@"message"];
                    
                    [self displayComplicatedError:returnMessage];
                } else {
                    NSString *nextTimer = [results objectForKey:@"nexttime"];
                    [AppDelegate.userDefaults setObject:nextTimer forKey:@"nextTimer"];
                }
                
            } else {
                [self displayComplicatedError:@"No Data - JSON"];
            }
        } else {
            [self displayComplicatedError:@"No Data - Communication Error"];
        }
    }
    return [AppDelegate.userDefaults objectForKey:@"nextTimer"];
}

// Which Timer
-(NSString *)whichTimerShouldIUse {
    return [AppDelegate.userDefaults objectForKey:@"nextTimer"];
}

// Compare time until that timer (tick)
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
    
    // View has loaded, but it hasn't UNLOADED
    AppDelegate.countdownViewHasLoaded = (bool*)YES;
    AppDelegate.countdownViewHasUnloaded = (bool *)NO;
    
    return elapsedSeconds;
}

-(NSDate*)wrudDateFormatter:(NSString*)dateIn {
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
    countDownLabelOutlet.text = [NSString stringWithFormat:@"Next survey in... %02d:%02d:%02d.", hours, minutes, seconds];
    
    if (hours == 0 && minutes == 0 && seconds == 0) {
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"surveyView"];
        [self presentViewController:vc animated:NO completion:nil];
    }
}

-(void)countdownTimer {
    secondsLeft = hours = minutes = seconds = 0;
    if([timer isValid]) { }
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateCounter:) userInfo:nil repeats:YES];
}


// View Controller Methods
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self updateNextTimer];
    
    [self countdownTimer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewWillDisappear:) name:UIApplicationDidEnterBackgroundNotification object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated {
    NSLog(@"View Received 'WillDisappear' or 'DidEnterBackground', loading in for a local notification...");
    
    NSDate *timerFireDate = [self wrudDateFormatter:[self updateNextTimer]];
    
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = timerFireDate;
    localNotification.alertBody = [NSString stringWithFormat:@"It's time to fill in what you are doing! Tap here to come back."];
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    localNotification.hasAction = true;
    localNotification.alertAction = @"return for survey.";
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

- (IBAction)exitViewButtonPressed:(id)sender {
}
@end
