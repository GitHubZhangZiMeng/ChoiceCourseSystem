//
//  UserManager.m
//  ChoiceCourseSystem
//
//  Created by monst on 16/4/8.
//  Copyright © 2016年 zzm. All rights reserved.
//

#import "UserManager.h"

@implementation UserManager

+ (NSUserDefaults *)shareUserManager
{
    static NSUserDefaults *userManager = nil;
    if (!userManager)
    {
        userManager = [NSUserDefaults standardUserDefaults];
    }
    return userManager;
    
}

- (void)SaveUserInfo:(NSString *)UserName andPWD:(NSString *)password
{
    [[UserManager shareUserManager] setObject:UserName forKey:@"username"];
    [[UserManager shareUserManager] setObject:password forKey:@"password"];
     [[UserManager shareUserManager] setObject:@"YES" forKey:@"LoginState"];
    [[UserManager shareUserManager] synchronize];
}

- (void)ClearUserInfo
{
    [[UserManager shareUserManager] removeObjectForKey:@"username"];
    [[UserManager shareUserManager] removeObjectForKey:@"password"];
    [[UserManager shareUserManager] setObject:@"NO" forKey:@"LoginState"];
}

- (NSString *)GetUsername
{
    return [[UserManager shareUserManager] objectForKey:@"username"];
}

@end
