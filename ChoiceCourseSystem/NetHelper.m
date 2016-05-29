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
        AFManager = [AFHTTPSessionManager manager];
    }
//    AFManager.responseSerializer.acceptableContentTypes = nil;
    return AFManager;
}


- (AFHTTPSessionManager *)AFHTTPManager
{
    return [NetHelper shareAFManager];
}

+ (void)getRequest:(NSString *)urlStr withNetBlock:(netBlock)netblock withErrBlock:(errBlock)errblock
{
    
    
    [[NetHelper shareAFManager] GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        netblock(responseObject);
        NSLog(@"++++%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errblock(error);
        NSLog(@"+++%@",error);
    }];
}

+ (void)getWaitRequest:(NSString *)urlStr withNetBlock:(netBlock)block withErrBlock:(errBlock)errblock
{
    NSURL *url=[NSURL URLWithString:urlStr];
    
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    
    NSURLSession *session=[NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"%@",data);
        NSLog(@"%@",response);
        NSLog(@"%@",error);
    }];
    
    [task resume];
    
}

+ (void)postRequest:(NSString *)urlStr withActionStr:(NSString *)action withDataStr:(NSString *)dataStr withNetBlock:(netBlock)block withErrBlock:(errBlock)errblock
{
    NSURLSession *session = [NSURLSession sharedSession];
    
    //2.根据会话对象创建task
    NSURL *url = [NSURL URLWithString:urlStr];
    //3.创建可变的请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //4.修改请求方法为POST
    request.HTTPMethod = @"POST";
    
    //5.设置请求体
//    NSString *str = @"{\"username\": \"zhaoqian\", \"password\": \"123456\"}";
    
    NSString *body = [NSString stringWithFormat:@"action=%@&data=%@",action,[dataStr base64EncodedString]];
    
    request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
    
    //6.根据会话对象创建一个Task(发送请求）
    /*
     26      第一个参数：请求对象
     27      第二个参数：completionHandler回调（请求完成【成功|失败】的回调）
     28                 data：响应体信息（期望的数据）
     29                 response：响应头信息，主要是对服务器端的描述
     30                 error：错误信息，如果请求失败，则error有值
     31      */
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        NSLog(@"%@",dict);
        block(dict);
    }];
    
    //7.执行任务
    [dataTask resume];
}


+ (void)postAsynchronousRequest:(NSString *)urlStr withActionStr:(NSString *)action withDataStr:(NSString *)dataStr withNetBlock:(netBlock)block withErrBlock:(errBlock)errblock
{
    [[NetHelper shareAFManager] POST:urlStr parameters:[NSString stringWithFormat:@"action=%@&data=%@",action,[dataStr base64EncodedString]] progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        block(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errblock(error);
    }];
}
@end
