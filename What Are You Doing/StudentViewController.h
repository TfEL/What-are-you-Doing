//
//  StudentViewController.h
//  What Are You Doing
//
//  Created by Aidan Cornelius-Bell on 6/07/2014.
//  Copyright (c) 2014 Department for Education and Child Development. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StudentViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *saveButtonReference;

@property (strong, nonatomic) IBOutlet UITextView *descriptorTextOne;
@property (strong, nonatomic) IBOutlet UITextView *descriptorTextTwo;
@property (strong, nonatomic) IBOutlet UITextView *descriptorTextThree;

@property (strong, nonatomic) IBOutlet UILabel *lessonCodeOutlet;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentOne;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentTwo;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentThree;

- (IBAction)segmentOneTouch:(id)sender;
- (IBAction)segmentTwoTouch:(id)sender;
- (IBAction)segmentThreeTouch:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *helpView;

- (IBAction)saveButtonPress:(id)sender;
@end
