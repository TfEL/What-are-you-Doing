//
//  StudentViewController.m
//  What Are You Doing
//
//  Created by Aidan Cornelius-Bell on 6/07/2014.
//  Copyright (c) 2014 Department for Education and Child Development. All rights reserved.
//

#import "StudentViewController.h"

#import "AppDelegate.h"

#define AppDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

@interface StudentViewController ()

@end

@implementation StudentViewController

@synthesize saveButtonReference, descriptorTextOne, descriptorTextThree, descriptorTextTwo, lessonCodeOutlet, segmentOne, segmentTwo, segmentThree, helpView;

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
    [[saveButtonReference layer] setCornerRadius:8.0f];
    [[saveButtonReference layer] setMasksToBounds:YES];
    [[saveButtonReference layer] setBorderWidth:1.0f];
    [[saveButtonReference layer] setBorderColor:[UIColor colorWithRed:(128/255.0) green:(202/255.0) blue:(201/255.0) alpha:1].CGColor];
    
    self.lessonCodeOutlet.text = [NSString stringWithFormat:@"Lesson Code: %@", AppDelegate.lessonCode];
    self.descriptorTextOne.text = AppDelegate.groupOneText;
    self.descriptorTextTwo.text = AppDelegate.groupTwoText;
    self.descriptorTextThree.text = AppDelegate.groupThreeText;
    
    if (AppDelegate.studentHasSeenHelp == NO) {
        self.helpView.hidden = false;
    } else {
        NSLog(@"[Not displaying help] Student has seen help");
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)displayComplicatedError:(NSString*)errorMessage {
    [[[UIAlertView alloc] initWithTitle:@"Communication Error"
                                message:errorMessage
                               delegate:nil
                      cancelButtonTitle:@"Try again"
                      otherButtonTitles:nil] show];
}

- (IBAction)segmentOneTouch:(id)sender {
    self.helpView.hidden = true;
    AppDelegate.studentHasSeenHelp = (bool*)true;
    [self.segmentTwo setSelectedSegmentIndex:UISegmentedControlNoSegment];
    [self.segmentThree setSelectedSegmentIndex:UISegmentedControlNoSegment];
}

- (IBAction)segmentTwoTouch:(id)sender {
    self.helpView.hidden = true;
    AppDelegate.studentHasSeenHelp = (bool*)true;
    [self.segmentOne setSelectedSegmentIndex:UISegmentedControlNoSegment];
    [self.segmentThree setSelectedSegmentIndex:UISegmentedControlNoSegment];
}

- (IBAction)segmentThreeTouch:(id)sender {
    self.helpView.hidden = true;
    AppDelegate.studentHasSeenHelp = (bool*)true;
    [self.segmentOne setSelectedSegmentIndex:UISegmentedControlNoSegment];
    [self.segmentTwo setSelectedSegmentIndex:UISegmentedControlNoSegment];
}

- (IBAction)saveButtonPress:(id)sender {
    self.helpView.hidden = true;
    NSLog(@"%ld", (long)self.segmentOne.selectedSegmentIndex);
    NSLog(@"%ld", (long)self.segmentTwo.selectedSegmentIndex);
    NSLog(@"%ld", (long)self.segmentThree.selectedSegmentIndex);
    
    NSString *surveyCompleteEndpoint = @"survey_exchange.php";
    
    NSString *submissionClassCode = [AppDelegate.userDefaults objectForKey:@"classCode"];
    
    NSString *submissionStudentIdentity = [AppDelegate.userDefaults objectForKey:@"studentIdentification"];
    
    NSString *submissionStudentSelection;
    
    if ([self.segmentOne selectedSegmentIndex] >= 0) {
        NSLog(@"Seg1: Was greater than 1");
        submissionStudentSelection = [NSString stringWithFormat:@"1:%ld", (long)self.segmentOne.selectedSegmentIndex];
    } if ([self.segmentTwo selectedSegmentIndex] >= 0) {
        NSLog(@"Seg2: Was greater than 1");
        submissionStudentSelection = [NSString stringWithFormat:@"2:%ld", (long)self.segmentTwo.selectedSegmentIndex];
    } if ([self.segmentThree selectedSegmentIndex] >= 0) {
        NSLog(@"Seg3: Was greater than 1");
        submissionStudentSelection = [NSString stringWithFormat:@"3:%ld", (long)self.segmentThree.selectedSegmentIndex];
    }
    
    NSString *queryString = [NSString stringWithFormat:@"%1@%2@?classcode=%3@&studentid=%4@&submission=%5@", AppDelegate.apiBaseURL, surveyCompleteEndpoint, submissionClassCode, submissionStudentIdentity, submissionStudentSelection];

    NSError *error;
    
    NSData *returnedData = [NSData dataWithContentsOfURL: [NSURL URLWithString:queryString] options:NSDataReadingUncached error:&error];
    
    if (error) {
        NSString *errorMessage = [NSString stringWithFormat:@"App was unable to communicate with the server, is your WiFi / Mobile connected?"];
        [self displayComplicatedError:errorMessage];
    } else {
        NSLog(@"Communication Successful");
        
        if(NSClassFromString(@"NSJSONSerialization")) {
            // Setup an empty error
            NSError *error = nil;
            // Convert the data to a json object
            id object = [NSJSONSerialization JSONObjectWithData:returnedData options:0 error:&error];
            // If there was nothing, fill the error...
            if(error) {
                
            }
            if([object isKindOfClass:[NSDictionary class]]) {
                NSDictionary *results = object;
                NSLog(@"%@", results);
                
                NSString *returnCode = [results objectForKey:@"return"];
                NSString *message = [results objectForKey:@"message"];
                
                if ([returnCode isEqualToString:@"fail"]) {
                    NSString *errorMessage = [NSString stringWithFormat:@"%@", message];
                    [self displayComplicatedError:errorMessage];
                } else {
                    
                    NSString *success = [results objectForKey:@"return"];
                    NSString *message = [results objectForKey:@"message"];
                    
                    NSLog(@"Received successfully: %@ : %@", success, message);
                    
                    if ([success isEqualToString:@"success"]) {
                        
                        NSUInteger lastTimerPassed = [AppDelegate.userDefaults integerForKey:@"lastTimerPassed"];
                        
                        lastTimerPassed++;
                        
                        [AppDelegate.userDefaults setInteger:lastTimerPassed forKey:@"lastTimerPassed"];
                        
                        NSLog(@"Timer Passed, next timer: %lu", (unsigned long)lastTimerPassed);
                        
                        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                        UIViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"countdownView"];
                        [self presentViewController:vc animated:NO completion:nil];
                    } else {
                        NSString *errorMessage = [NSString stringWithFormat:@"%@", message];
                        [self displayComplicatedError:errorMessage];
                    }
                }
                
            } else {
                NSString *errorMessage = [NSString stringWithFormat:@"App was unable to communicate with the server, is your WiFi / Mobile connected?"];
                [self displayComplicatedError:errorMessage];
            }
        } else {
            NSString *errorMessage = [NSString stringWithFormat:@"App was unable to communicate with the server, is your WiFi / Mobile connected?"];
            [self displayComplicatedError:errorMessage];
        }
    }
    
}
@end
