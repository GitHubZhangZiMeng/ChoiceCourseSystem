//
//  UIViewController+Alert.m
//  ChoiceCourseSystem
//
//  Created by monst on 16/4/6.
//  Copyright © 2016年 zzm. All rights reserved.
//

#import "UIViewController+Alert.h"

@interface UIViewController (_Alert)

@end

@implementation UIViewController (_Alert)

- (void)showAlert
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notNet) name:@"netWorkState" object:nil];
}

- (void)notNet
{
    [AlertNotice showAlert:0 withTitle:nil withContent:nil withVC:self clickLeftBtn:^{
        [self dismissViewControllerAnimated:YES completion:nil];
    } clickRightBtn:^{
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end