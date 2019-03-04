//
//  NSObject+CSTool.m
//  CSinaWeibo
//
//  Created by 🐙怪兽 on 2019/2/23.
//  Copyright © 2019 com.😈. All rights reserved.
//

#import "NSObject+CSTool.h"
#import <AFNetworking.h>

NSString * const TokenForbiddenNotification = @" 403 Forbidden Notification";
@implementation NSObject (CSTool)

//统一解析响应体,处理异常等.
- (NSDictionary *)serializationDataWithResponse:(NSURLResponse *)response data:(NSData *)data error:(NSError *)error {
    if (error) NSLog(@"请求错误  error: %@",error.localizedDescription);

    NSDictionary *json;
    NSHTTPURLResponse *res = (NSHTTPURLResponse*)response;
    switch (res.statusCode) {
        case 200:
            if (data) {
                json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
                if (error) NSLog(@"Serialization Error:%@",error);
            }
            break;
        case 400:
            break;
        case 401:{ //未授权
            [[NSNotificationCenter defaultCenter] postNotificationName:TokenForbiddenNotification object:nil];
        }
            break;
        case 403:{ //服务器拒绝请求。
            NSLog(@"接口调用次数限制");
            //[[NSNotificationCenter defaultCenter] postNotificationName:TokenForbiddenNotification object:nil];
        }
            break;

        default:
            break;
    }
    return json;
}

//封装发起任务请求操作,通过block 回调返回数据.
- (void)dataTaskWithRequest:(NSURLRequest*)request handler:(RequestCallBack)handle {

    //NSLog(@"request =%@",request);

    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"error = %@",error.localizedDescription);
        }

        //统一处理返回的数据,响应体等,不管是否有回调, 在解析中都处理请求结果.
        NSDictionary *json = [self serializationDataWithResponse:response data:data error:error];
        if (handle) {
            dispatch_async(dispatch_get_main_queue(), ^{
                handle(json,(NSHTTPURLResponse*)response);
            });
        }
    }] resume];


}

- (AFHTTPSessionManager*)shareHTTPSessionManager{
    NSURLSessionConfiguration *configuration = [[NSURLSessionConfiguration alloc] init];
    return [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
}

- (AFURLSessionManager*)shareURLSessionManager{
    NSURLSessionConfiguration *configuration = [[NSURLSessionConfiguration alloc] init];
    return [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
}
@end
