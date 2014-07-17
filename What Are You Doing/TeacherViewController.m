//
//  TeacherViewController.m
//  What Are You Doing
//
//  Created by Aidan Cornelius-Bell on 6/07/2014.
//  Copyright (c) 2014 Department for Education and Child Development. All rights reserved.
//

#import "TeacherViewController.h"

#import "AppDelegate.h"

#define AppDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

@interface TeacherViewController ()

@end

@implementation TeacherViewController

@synthesize setupButtonReference, codeFieldReference;

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
    
    [[setupButtonReference layer] setCornerRadius:8.0f];
    [[setupButtonReference layer] setMasksToBounds:YES];
    [[setupButtonReference layer] setBorderWidth:1.0f];
    [[setupButtonReference layer] setBorderColor:[UIColor orangeColor].CGColor];
    
    [codeFieldReference becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

void errorNotification() {
    [[[UIAlertView alloc] initWithTitle:@"Code Error"
                                message:@"We couldnt find that code, are you sure it was correct?"
                               delegate:nil
                      cancelButtonTitle:@"Try again"
                      otherButtonTitles:nil] show];
}

- (IBAction)setupButtonPress:(id)sender {
    
    NSString *classCodeText = [NSString stringWithFormat:@"Code Received: %@", codeFieldReference.text];
    
    NSLog(@"%@", classCodeText);
    
    NSString *cleanedCodeReference;
    
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    
    NSString *trimmed = [codeFieldReference.text stringByTrimmingCharactersInSet:whitespace];
    if ([trimmed length] == 0) {
        // Text was empty or only whitespace.
        cleanedCodeReference = @"000";
    } else {
        cleanedCodeReference = codeFieldReference.text;
    }
    
    NSString *surveyCompleteEndpoint = @"exchange.php";
    
    NSString *requestURL = [NSString stringWithFormat:@"%1@%2@?challenge=%3@", AppDelegate.apiBaseURL, surveyCompleteEndpoint, cleanedCodeReference];
    
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
                errorNotification();
            }
            if([object isKindOfClass:[NSDictionary class]]) {
                NSDictionary *results = object;
                NSLog(@"%@", results);
                
                NSString *returnCode = [results objectForKey:@"return"];
                
                if ([returnCode isEqualToString:@"fail"]) {
                    errorNotification();
                } else {
                    
                    NSString *textOne = [results objectForKey:@"groupOneText"];
                    NSString *textTwo = [results objectForKey:@"groupTwoText"];
                    NSString *textThree = [results objectForKey:@"groupThreeText"];
                    NSString *studentID = [results objectForKey:@"studentIdentification"];
                    
                    NSString *timerOne = [results objectForKey:@"timerTimeOne"];
                    NSString *timerTwo = [results objectForKey:@"timerTimeTwo"];
                    NSString *timerThree = [results objectForKey:@"timerTimeThree"];
                    NSString *timerFour = [results objectForKey:@"timerTimeFour"];
                    NSString *timerFive = [results objectForKey:@"timerTimeFive"];
                    NSString *timerSix = [results objectForKey:@"timerTimeSix"];
                    NSString *timerSeven = [results objectForKey:@"timerTimeSeven"];
                    NSString *timerEight = [results objectForKey:@"timerTimeEight"];
                    NSString *timerNine = [results objectForKey:@"timerTimeNine"];
                    NSString *timerTen = [results objectForKey:@"timerTimeTen"];
                    
                    
                    AppDelegate.groupOneText = textOne;
                    AppDelegate.groupTwoText = textTwo;
                    AppDelegate.groupThreeText = textThree;
                    AppDelegate.studentIdentification = studentID;
                    AppDelegate.lessonCode = cleanedCodeReference;
                    
                    NSLog(@"Anonymous Student ID: %@", studentID);
                    
                    AppDelegate.setupCompleted = @"yes";
                    
                    // Make some settings!!! Timers are going to need to work differently.
                    [AppDelegate.userDefaults setObject:cleanedCodeReference forKey:@"classCode"];
                    // Group texts
                    [AppDelegate.userDefaults setObject:textOne forKey:@"groupOneText"];
                    [AppDelegate.userDefaults setObject:textTwo forKey:@"groupTwoText"];
                    [AppDelegate.userDefaults setObject:textThree forKey:@"groupThreeText"];
                    // Anonym Student ID
                    [AppDelegate.userDefaults setObject:studentID forKey:@"studentIdentification"];
                    // Saving values twice, for safety, or something...
                    [AppDelegate.userDefaults setObject:timerOne forKey:@"TimerOne"];
                    [AppDelegate.userDefaults setObject:timerTwo forKey:@"TimerTwo"];
                    [AppDelegate.userDefaults setObject:timerThree forKey:@"TimerThree"];
                    [AppDelegate.userDefaults setObject:timerFour forKey:@"TimerFour"];
                    [AppDelegate.userDefaults setObject:timerFive forKey:@"TimerFive"];
                    [AppDelegate.userDefaults setObject:timerSix forKey:@"TimerSix"];
                    [AppDelegate.userDefaults setObject:timerSeven forKey:@"TimerSeven"];
                    [AppDelegate.userDefaults setObject:timerEight forKey:@"TimerEight"];
                    [AppDelegate.userDefaults setObject:timerNine forKey:@"TimerNine"];
                    [AppDelegate.userDefaults setObject:timerTen forKey:@"TimerTen"];
                    
                    // Reset the timer count...
                    [AppDelegate.userDefaults setObject:@"0" forKey:@"lastTimerPassed"];
                    
                    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                    UIViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"setupCompleted"];
                    [self presentViewController:vc animated:NO completion:nil];
                }
                
            } else {
                errorNotification();
            }
        } else {
            errorNotification();
        }
    }
    
    [codeFieldReference resignFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

@end
