//
//  ViewController.m
//  KVZTestNotification
//
//  Created by kevinzhan on 24/8/16.
//  Copyright © 2016年 kevinzhan. All rights reserved.
//

#import "ViewController.h"
@import Intents;
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pressPushBtn:(id)sender {
    //设置通知内容
    UNMutableNotificationContent* content = [[UNMutableNotificationContent alloc] init];
    content.title = @"Hello!";
    content.body = @"我的天呐！！！";
    content.sound = [UNNotificationSound defaultSound];
    content.categoryIdentifier = @"testCategory";
    //设置附件，通知会出现一个缩略图，注意只能是本地文件。
    NSString *path = [[NSBundle mainBundle] pathForResource:@"qiefm" ofType:@"png"];
    NSURL *url = [NSURL fileURLWithPath:path];
    content.attachments = @[[UNNotificationAttachment attachmentWithIdentifier:@"image" URL:url options:nil error:nil]];
    //设置trigger
    UNTimeIntervalNotificationTrigger* trigger = [UNTimeIntervalNotificationTrigger
                                                  triggerWithTimeInterval:5 repeats:NO];
    //构建通知类
    UNNotificationRequest* request = [UNNotificationRequest requestWithIdentifier:@"FiveSecond"
                                                                          content:content trigger:trigger];
    //将通知加到通知中心
    UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"error %@",error);
        }else {
            NSLog(@"done push");
        }
    }];
}
- (IBAction)pressChangeBtn:(id)sender {
    UNMutableNotificationContent* content = [[UNMutableNotificationContent alloc] init];
    content.title = [NSString localizedUserNotificationStringForKey:@"Hey!" arguments:nil];
    content.body = [NSString localizedUserNotificationStringForKey:@"变了呐！！！"
                                                         arguments:nil];
    content.sound = [UNNotificationSound defaultSound];
    content.categoryIdentifier = @"testCategory";
    
    // Deliver the notification in five seconds.
    UNTimeIntervalNotificationTrigger* trigger = [UNTimeIntervalNotificationTrigger
                                                  triggerWithTimeInterval:3 repeats:NO];
    UNNotificationRequest* request = [UNNotificationRequest requestWithIdentifier:@"FiveSecond"
                                                                          content:content trigger:trigger];
    
    // Schedule the notification.
    UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"error %@",error);
        }else {
            NSLog(@"done push");
        }
    }];
    
}





@end
