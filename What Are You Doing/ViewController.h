//
//  ViewController.h
//  What Are You Doing
//
//  Created by Aidan Cornelius-Bell on 3/07/2014.
//  Copyright (c) 2014 Department for Education and Child Development. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *studentButton;
@property (strong, nonatomic) IBOutlet UIButton *teachMeOutlet;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *padlockButtonOutlet;

- (IBAction)padlockButton:(id)sender;

@end
