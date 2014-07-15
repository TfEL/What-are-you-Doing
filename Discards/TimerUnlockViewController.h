//
//  TimerUnlockViewController.h
//  What Are You Doing
//
//  Created by Aidan Cornelius-Bell on 8/07/2014.
//  Copyright (c) 2014 Department for Education and Child Development. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimerUnlockViewController : UIViewController {
    NSTimer *timer;
}

- (IBAction)whatAreYouDoingButtonPress:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *whatAreYouDoingButtonOutlet;
@property (strong, nonatomic) IBOutlet UILabel *unlockTimerOutlet;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *spinnerOutlet;

@end
