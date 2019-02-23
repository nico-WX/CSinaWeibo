//
//  CSAuthorizePath.h
//  CSinaWeibo
//
//  Created by 🐙怪兽 on 2019/2/22.
//  Copyright © 2019 com.😈. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CSLoginUser;
NS_ASSUME_NONNULL_BEGIN

//授权地址
@interface CSAuthorizePath : NSObject
@property(nonatomic,copy,readonly) NSString *requestAuthorizePath;
- (NSString*)requestAccessTokenPathWithCode:(NSString*)code;

@end


NS_ASSUME_NONNULL_END
