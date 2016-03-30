//
//  AppDelegate.m
//  ChoiceCourseSystem
//
//  Created by zzm on 16/2/18.
//  Copyright © 2016年 zzm. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    self.window.rootViewController = loginVC;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkState) name:kReachabilityChangedNotification object:nil];
    
    self.connection = [Reachability reachabilityForInternetConnection];
    [self.connection startNotifier];
    
    return YES;
}

- (void)networkState
{
    Reachability *wifi = [Reachability reachabilityForLocalWiFi];
    Reachability *conn = [Reachability reachabilityForInternetConnection];
    if ([wifi currentReachabilityStatus] != NotReachable)
    {
        NSLog(@"wifi");
    }
    else if ([conn currentReachabilityStatus] != NotReachable)
    {
        NSLog(@"蜂窝");
    }
    else
    {
        NSLog(@"没有网络");
        [[NSNotificationCenter defaultCenter] postNotificationName:@"netWorkState" object:nil];
    }
}

- (void)dealloc
{
    [self.connection stopNotifier];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
