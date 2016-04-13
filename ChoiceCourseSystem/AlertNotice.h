//
//  AlertNotice.h
//  ChoiceCourseSystem
//
//  Created by monst on 16/4/1.
//  Copyright © 2016年 zzm. All rights reserved.
//

typedef void(^clickCallBack)();


#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,AlertNoticeType)
{
    
    kEnterThePwd = 0,
    kEnterOutSystem = 1,
    kEnterCommitCourse = 2
};


@interface AlertNotice : NSObject


+(void)showAlert: (AlertNoticeType)type withTitle:(NSString *)title withContent:(NSString *)content withVC:(UIViewController *)vc clickLeftBtn:(clickCallBack)leftCallBack clickRightBtn:(clickCallBack)rightCallBack;

+ (void)showAlertNotType :(NSString *)title withContent:(NSString *)content withVC:(UIViewController *)vc clickLeftBtn:(clickCallBack)CallBack;

@end
