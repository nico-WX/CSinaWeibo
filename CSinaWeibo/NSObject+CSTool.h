//
//  NSObject+CSTool.h
//  CSinaWeibo
//
//  Created by 🐙怪兽 on 2019/2/23.
//  Copyright © 2019 com.😈. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN



extern NSString * const TokenForbiddenNotification;

//请求数据回调
typedef void(^RequestCallBack)(NSDictionary* json, NSHTTPURLResponse* response);

@interface NSObject (CSTool)

/**
 统一处理响应头信息,处理授权Token 解析响应体 并返回字典(如果有返回)
 */
- (NSDictionary*_Nullable)serializationDataWithResponse:(NSURLResponse* _Nullable)response
                                                   data:(NSData*_Nullable)data
                                                  error:(NSError*_Nullable)error;

/**
 封装请求操作 通过回调返回json数据
 */
- (void)dataTaskWithRequest:(NSURLRequest*)request handler:(RequestCallBack)handle;

@end

NS_ASSUME_NONNULL_END
