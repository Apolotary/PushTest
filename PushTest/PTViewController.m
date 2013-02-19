//
//  PTViewController.m
//  PushTest
//
//  Created by Bektur Ryskeldiev on 19.02.13.
//  Copyright (c) 2013 sibers. All rights reserved.
//

#import "PTViewController.h"

@interface PTViewController ()

@end

@implementation PTViewController

NSString *const kPushRegisteredNotification           = @"PushRegistered";
NSString *const kPushRegistrationFailedNotification   = @"PushRegistrationFailed";
NSString *const kPushReceivedNotification             = @"PushReceived";
NSString *const kPushDataStringKey                    = @"PushDataString";

#pragma mark - IBAction methods

- (IBAction)reregisterButtonPressed:(id)sender
{
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
     (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
}

- (void) addToTextViewNotificationData: (NSDictionary *) userInfo
{
    NSString *resultString = userInfo[kPushDataStringKey];
    
    [_pushTextView setText:[NSString stringWithFormat:@"%@ \n %@", _pushTextView.text, resultString]];
    [_pushTextView scrollRangeToVisible:NSMakeRange([_pushTextView.text length], 0)];
}

#pragma mark - Notificaiton callbacks

- (void) pushNotificationRegistered: (NSNotification *) notification
{
    [self addToTextViewNotificationData:notification.userInfo];
}

- (void) pushNotificationRegistrationFailed: (NSNotification *) notification
{
    [self addToTextViewNotificationData:notification.userInfo];
}

- (void) pushNotificationReceivedData: (NSNotification *) notification
{
    [self addToTextViewNotificationData:notification.userInfo];
}

#pragma mark - Registering to NSNotificationCenter

- (void) addObservers
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushNotificationRegistered:) name:kPushRegisteredNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushNotificationRegistrationFailed:) name:kPushRegistrationFailedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushNotificationReceivedData:) name:kPushReceivedNotification object:nil];
}

- (void) removeObservers
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kPushRegisteredNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kPushRegistrationFailedNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kPushReceivedNotification object:nil];
}

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void) viewWillAppear:(BOOL)animated
{
    [self addObservers];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [self removeObservers];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
