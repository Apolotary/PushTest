//
//  PTViewController.h
//  PushTest
//
//  Created by Bektur Ryskeldiev on 19.02.13.
//  Copyright (c) 2013 sibers. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const kPushRegisteredNotification;
extern NSString *const kPushRegistrationFailedNotification;
extern NSString *const kPushReceivedNotification;
extern NSString *const kPushDataStringKey;

@interface PTViewController : UIViewController
{
    IBOutlet UITextView *_pushTextView;
}

- (IBAction)reregisterButtonPressed:(id)sender;

@end
