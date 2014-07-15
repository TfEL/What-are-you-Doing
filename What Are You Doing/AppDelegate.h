//
//  AppDelegate.h
//  What Are You Doing
//
//  Created by Aidan Cornelius-Bell on 3/07/2014.
//  Copyright (c) 2014 Department for Education and Child Development. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

// Globals

@property (nonatomic) NSString *lessonCode;

@property (nonatomic) NSString *setupCompleted;

@property (nonatomic) NSString *groupOneText;

@property (nonatomic) NSString *groupTwoText;

@property (nonatomic) NSString *groupThreeText;

@property (nonatomic) NSString *studentIdentification;

// User defaults

@property (nonatomic) NSUserDefaults *userDefaults;

@end
