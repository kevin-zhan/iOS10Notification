//
//  AppDelegate.m
//  KVZTestNotification
//
//  Created by kevinzhan on 24/8/16.
//  Copyright © 2016年 kevinzhan. All rights reserved.
//

#import "AppDelegate.h"
@import Intents;
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
    [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert + UNAuthorizationOptionSound)
                          completionHandler:^(BOOL granted, NSError * _Nullable error) {
                              // Enable or disable features based on authorization.
                              if (granted) {
                                  NSLog(@"ok to push");
                                  
                                  [[UIApplication sharedApplication] registerForRemoteNotifications];
                                  
                              }else {
                                  NSLog(@"not push");
                              }
                          }];
    center.delegate = self;
    
    NSArray *actions = @[[UNTextInputNotificationAction actionWithIdentifier:@"inputSomething" title:@"写写" options:UNNotificationActionOptionForeground textInputButtonTitle:@"OK" textInputPlaceholder:@"写点什么呗！"],[UNNotificationAction actionWithIdentifier:@"showDetail" title:@"看看" options:UNNotificationActionOptionForeground]];
    
    UNNotificationCategory *category = [UNNotificationCategory categoryWithIdentifier:@"testCategory" actions:actions intentIdentifiers:@[INSetMessageAttributeIntentIdentifier] options:UNNotificationCategoryOptionCustomDismissAction];
    [center setNotificationCategories:[NSSet setWithObject:category]];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"device token: %@",deviceToken);
}
- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler {
    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionAlert);
    
}
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())completionHandler {
    if ([response isMemberOfClass:[UNTextInputNotificationResponse class]]) {
        NSLog(@"user input: %@",((UNTextInputNotificationResponse *)response).userText);
    }
    completionHandler();
}

@end
