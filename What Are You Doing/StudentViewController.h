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
- (IBAction)saveButtonPress:(id)sender;

@end
