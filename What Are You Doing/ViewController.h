//
//  ViewController.h
//  What Are You Doing
//
//  Created by Aidan Cornelius-Bell on 3/07/2014.
//  Copyright (c) 2014 Department for Education and Child Development. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController {
    NSTimer *timer;
}

// Outlet for countdown timer
@property (weak, nonatomic) IBOutlet UILabel *countDownLabelOutlet;

// Not sure if we'll use this to pool the queue or not...
- (IBAction)exitViewButtonPressed:(id)sender;

@end
