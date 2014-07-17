//
//  AppDelegate.m
//  What Are You Doing
//
//  Created by Aidan Cornelius-Bell on 3/07/2014.
//  Copyright (c) 2014 Department for Education and Child Development. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize apiBaseURL, userDefaults, lessonCode, studentIdentification, setupCompleted, groupOneText, groupTwoText, groupThreeText;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    NSLog(@"WruD Client: Initialised");
    
    // The defaults are...
    userDefaults = [NSUserDefaults standardUserDefaults];
    
    // Sync defaults
    [userDefaults synchronize];
    
    // Reset helpview
    self.studentHasSeenHelp = false;
    
    self.apiBaseURL = @"https://wrud.tfel.edu.au/api/";
    
    // Confirm local notifcations (iOS 8)
    //[application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
    
    if ([userDefaults objectForKey:@"classCode"] == nil) {
        lessonCode = [[NSString alloc] init];
        groupOneText = [[NSString alloc] init];
        groupTwoText = [[NSString alloc] init];
        groupThreeText = [[NSString alloc] init];
        setupCompleted = [[NSString alloc] init];
        studentIdentification = [[NSString alloc] init];
        
        NSUInteger lastTimerPassed = 0;
        
        [userDefaults setInteger:lastTimerPassed forKey:@"lastTimerPassed"];
        
        NSLog(@"WRUD didn't detect any saved userDefaults: (nil).");
        
        setupCompleted = @"no";
    } else {
        NSLog(@"WRUD detected saved userDefaults: %@.", userDefaults);
        
        lessonCode = [userDefaults objectForKey:@"classCode"];
        groupOneText = [userDefaults objectForKey:@"groupOneText"];
        groupTwoText = [userDefaults objectForKey:@"groupTwoText"];
        groupThreeText = [userDefaults objectForKey:@"groupThreeText"];
        studentIdentification = [userDefaults objectForKey:@"studentIdentification"];
        
        NSLog(@"WRUD Resumed with these values: %@, ***  %@, *** %@, *** %@, *** %@.", lessonCode, groupOneText, groupTwoText, groupThreeText, studentIdentification);
        
        setupCompleted = @"yes";
    }
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [userDefaults synchronize];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    NSLog(@"Application terminated.");
}

- (void)application:(UIApplication *)app didReceiveLocalNotification:(UILocalNotification *)notif {
    // Handle the notificaton when the app is running
    NSLog(@"Recieved Notification %@",notif);
}

@end
