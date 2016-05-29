//
//  NetHelper.h
//  ChoiceCourseSystem
//
//  Created by monst on 16/4/5.
//  Copyright © 2016年 zzm. All rights reserved.
//

typedef void(^netBlock)(id responseObject);
typedef void(^errBlock)(id err);

#import <Foundation/Foundation.h>

@interface NetHelper : NSObject

+ (void)getRequest:(NSString *)urlStr withNetBlock:(netBlock)block withErrBlock:(errBlock)errblock;

+ (void)getWaitRequest:(NSString *)urlStr withNetBlock:(netBlock)block withErrBlock:(errBlock)errblock;

+ (void)postRequest:(NSString *)urlStr withActionStr:(NSString *)action withDataStr:(NSString *)dataStr withNetBlock:(netBlock)block withErrBlock:(errBlock)errblock;

+ (void)postAsynchronousRequest:(NSString *)urlStr withActionStr:(NSString *)action withDataStr:(NSString *)dataStr withNetBlock:(netBlock)block withErrBlock:(errBlock)errblock;
@end
