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

@synthesize saveButtonReference, descriptorTextOne, descriptorTextThree, descriptorTextTwo, lessonCodeOutlet;

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
    [[saveButtonReference layer] setBorderColor:[UIColor orangeColor].CGColor];
    
    self.lessonCodeOutlet.text = [NSString stringWithFormat:@"Lesson Code: %@", AppDelegate.lessonCode];
    self.descriptorTextOne.text = AppDelegate.groupOneText;
    self.descriptorTextTwo.text = AppDelegate.groupTwoText;
    self.descriptorTextThree.text = AppDelegate.groupThreeText;
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

- (IBAction)saveButtonPress:(id)sender {
    
}
@end
