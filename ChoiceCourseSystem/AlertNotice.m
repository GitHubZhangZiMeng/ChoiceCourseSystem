//
//  AlertNotice.m
//  ChoiceCourseSystem
//
//  Created by monst on 16/4/1.
//  Copyright © 2016年 zzm. All rights reserved.
//

#import "AlertNotice.h"

@implementation AlertNotice


+ (AlertNotice *)shareAlert
{
    static AlertNotice *alert = nil;
    if (!alert)
    {
        alert = [[AlertNotice alloc] init];
    }
    return alert;
}


+ (void)showAlert:(AlertNoticeType)type withTitle:(NSString *)title withContent:(NSString *)content withVC:(id)vc clickLeftBtn:(clickCallBack)leftCallBack clickRightBtn:(clickCallBack)rightCallBack
{
    [[AlertNotice shareAlert] showAlert:type withTitle:title withContent:content withVC:vc clickLeftBtn:leftCallBack clickRightBtn:rightCallBack];
}
+ (void)showAlertNotType:(NSString *)title withContent:(NSString *)content withVC:(UIViewController *)vc clickLeftBtn:(clickCallBack)CallBack
{
    [[AlertNotice shareAlert] showAlertNotType:title withContent:content withVC:vc clickLeftBtn:CallBack];
}
- (void)showAlertNotType:(NSString *)title withContent:(NSString *)content withVC:(UIViewController *)vc clickLeftBtn:(clickCallBack)CallBack
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:content preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:0 handler:^(UIAlertAction * _Nonnull action) {
        CallBack();
    }];
    [alertController addAction:action];
    
    [vc presentViewController:alertController animated:YES completion:nil];
}



- (void)showAlert:(AlertNoticeType)type withTitle:(NSString *)title withContent:(NSString *)content withVC:(id)vc clickLeftBtn:(clickCallBack)leftCallBack clickRightBtn:(clickCallBack)rightCallBack
{
    NSString *leftBtnTitle;
    NSString *rightBtnTitle;
    switch (type)
    {
       
        case 1:
            title = @"提示";
            content = @"是否退出登录";
            leftBtnTitle = @"确定";
            rightBtnTitle = @"取消";
            break;
       
        case 0:
            title = @"提示";
            content = @"是否确定修改密码";
            leftBtnTitle = @"确定";
            rightBtnTitle = @"取消";
            break;
            
        default:
            break;
    }
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:content preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *leftAction = [UIAlertAction actionWithTitle:leftBtnTitle style:0 handler:^(UIAlertAction * _Nonnull action) {
        leftCallBack();
    }];
    UIAlertAction *rightAction = [UIAlertAction actionWithTitle:rightBtnTitle style:0 handler:^(UIAlertAction * _Nonnull action) {
        rightCallBack();
    }];
    
    [alertController addAction:leftAction];
    [alertController addAction:rightAction];
    
    [vc presentViewController:alertController animated:YES completion:nil];
    
}

@end
