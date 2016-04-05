//
//  NetHelper.m
//  ChoiceCourseSystem
//
//  Created by monst on 16/4/5.
//  Copyright © 2016年 zzm. All rights reserved.
//

#import "NetHelper.h"

@implementation NetHelper

+ (AFHTTPSessionManager *)shareAFManager
{
    static AFHTTPSessionManager *AFManager = nil;
    if (!AFManager)
    {
        AFManager = [[AFHTTPSessionManager alloc] init];
    }
    return AFManager;
}

- (AFHTTPSessionManager *)AFHTTPManager
{
    return [NetHelper shareAFManager];
}

- (void)getRequest:(NSString *)urlStr withNetBlock:(netBlock)netblock withErrBlock:(errBlock)errblock
{
    [[self AFHTTPManager] GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        netblock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errblock(error);
    }];
}

@end
