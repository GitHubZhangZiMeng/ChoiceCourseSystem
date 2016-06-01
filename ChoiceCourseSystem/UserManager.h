//
//  UserManager.h
//  ChoiceCourseSystem
//
//  Created by monst on 16/4/8.
//  Copyright © 2016年 zzm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserManager : NSObject

- (void)SaveUserInfo:(NSString *)UserName andPWD:(NSString *)password andUserid:(NSString *)userid;

- (void)ClearUserInfo;

- (NSString *)GetUsername;

- (NSString *)GetPassWord;

- (NSString *)getUserID;
@end
