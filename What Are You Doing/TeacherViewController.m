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

-(void)displayComplicatedError:(NSString*)errorMessage {
    [[[UIAlertView alloc] initWithTitle:@"Set Up Error"
                                message:errorMessage
                               delegate:nil
                      cancelButtonTitle:@"Try again"
                      otherButtonTitles:nil] show];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[setupButtonReference layer] setCornerRadius:8.0f];
    [[setupButtonReference layer] setMasksToBounds:YES];
    [[setupButtonReference layer] setBorderWidth:1.0f];
    [[setupButtonReference layer] setBorderColor:[UIColor colorWithRed:(128/255.0) green:(202/255.0) blue:(201/255.0) alpha:1].CGColor];
    
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
    
    NSString *surveyCompleteEndpoint = @"setup_exchange.php";
    
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
                    
                    NSString *textOne = [results objectForKey:@"groupOneText"];
                    NSString *textTwo = [results objectForKey:@"groupTwoText"];
                    NSString *textThree = [results objectForKey:@"groupThreeText"];
                    NSString *studentID = [results objectForKey:@"studentIdentification"];
                    
                    NSString *nextTimer = [results objectForKey:@"nextTimer"];
                    
                    
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
                    // Next Timer Time
                    [AppDelegate.userDefaults setObject:nextTimer forKey:@"nextTimer"];
                    
                    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                    UIViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"setupCompleted"];
                    [self presentViewController:vc animated:NO completion:nil];
                }
                
            } else {
                [self displayComplicatedError:@"No Data - JSON"];
            }
        } else {
            [self displayComplicatedError:@"No Data - Communication Error"];
        }
    }
    
    [codeFieldReference resignFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField==codeFieldReference || textField == codeFieldReference)
    {
        
        NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"];
        for (int i = 0; i < [string length]; i++)
        {
            unichar c = [string characterAtIndex:i];
            if (![myCharSet characterIsMember:c])
            {
                return NO;
            }
        }
        
        return YES;
    }
    
    return YES;
}


@end
