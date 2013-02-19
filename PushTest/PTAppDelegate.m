//
//  PTAppDelegate.m
//  PushTest
//
//  Created by Bektur Ryskeldiev on 19.02.13.
//  Copyright (c) 2013 sibers. All rights reserved.
//

#import "PTAppDelegate.h"

#import "PTViewController.h"

@interface PTAppDelegate ()
{
    NSString *_deviceToken;
}

@end

@implementation PTAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.viewController = [[PTViewController alloc] initWithNibName:@"PTViewController" bundle:nil];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
     (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    
    return YES;
}

#pragma mark - Notification-related delegate callbacks

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
	NSLog(@"My token is: %@", deviceToken.description);
    
    NSString *editedTokenString = [deviceToken.description stringByReplacingOccurrencesOfString:@" " withString:@""];
    editedTokenString = [editedTokenString stringByReplacingOccurrencesOfString:@"<" withString:@""];
    editedTokenString = [editedTokenString stringByReplacingOccurrencesOfString:@">" withString:@""];
    _deviceToken = editedTokenString;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kPushRegisteredNotification object:nil userInfo:@{kPushDataStringKey : [NSString stringWithFormat:@"Registered device, token: %@", _deviceToken]}];
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
	NSLog(@"Failed to get token, error: %@, %@, %@, %@", error.localizedDescription, error.localizedFailureReason, error.localizedRecoveryOptions, error.localizedRecoverySuggestion);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kPushRegistrationFailedNotification object:nil userInfo:@{kPushDataStringKey : [NSString stringWithFormat:@"Failed to get token, error: %@, %@, %@, %@", error.localizedDescription, error.localizedFailureReason, error.localizedRecoveryOptions, error.localizedRecoverySuggestion]}];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSLog(@"RECEIVED NOTIFICATION %@", userInfo);

    [[NSNotificationCenter defaultCenter] postNotificationName:kPushReceivedNotification object:nil userInfo:@{kPushDataStringKey : [NSString stringWithFormat:@"Received notification: %@", userInfo.description]}];
}

#pragma mark - Rest of application delegate callbacks

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
