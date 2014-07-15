//
//  CountdownViewController.h
//  What Are You Doing
//
//  Created by Aidan Cornelius-Bell on 11/07/2014.
//  Copyright (c) 2014 Department for Education and Child Development. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CountdownViewController : UIViewController {
    NSTimer *timer;
}
@property (weak, nonatomic) IBOutlet UILabel *countDownLabel;

@end
