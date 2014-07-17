//
//  AdvancedSettingsViewController.h
//  What Are You Doing
//
//  Created by Aidan Cornelius-Bell on 17/07/2014.
//  Copyright (c) 2014 Department for Education and Child Development. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdvancedSettingsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *resetAllSettingsOutlet;

@property (weak, nonatomic) IBOutlet UIButton *showGuideNextOutlet;

@property (weak, nonatomic) IBOutlet UIButton *changeAPIButtonOutlet;

- (IBAction)changeAPIButtonPress:(id)sender;

- (IBAction)resetAllSettingsPress:(id)sender;

- (IBAction)showGuideNextPress:(id)sender;

@end
