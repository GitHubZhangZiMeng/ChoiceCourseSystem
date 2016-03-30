//
//  AppDelegate.h
//  ChoiceCourseSystem
//
//  Created by zzm on 16/2/18.
//  Copyright © 2016年 zzm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) Reachability *connection;

@end

