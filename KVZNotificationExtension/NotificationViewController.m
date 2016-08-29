//
//  NotificationViewController.m
//  KVZNotificationExtension
//
//  Created by kevinzhan on 24/8/16.
//  Copyright © 2016年 kevinzhan. All rights reserved.
//

#import "NotificationViewController.h"
#import <UserNotifications/UserNotifications.h>
#import <UserNotificationsUI/UserNotificationsUI.h>

@interface NotificationViewController () <UNNotificationContentExtension>

@property IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UILabel *bodyLabel;

@end

@implementation NotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any required interface initialization here.
}

- (void)didReceiveNotification:(UNNotification *)notification {
    self.label.text = notification.request.content.title;
    self.bodyLabel.text = notification.request.content.body;
}

@end
