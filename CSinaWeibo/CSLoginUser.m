//
//  CSUser.m
//  CSinaWeibo
//
//  Created by 🐙怪兽 on 2019/2/22.
//  Copyright © 2019 com.😈. All rights reserved.
//

#import "CSLoginUser.h"
#import <MJExtension.h>


@interface CSLoginUser ()
//@property(nonatomic,copy,readonly) NSString *access_token;
@property(nonatomic,assign) NSUInteger expires_in;
@property(nonatomic,assign) BOOL isRealName;
@property(nonatomic,assign) NSUInteger uid;
@end

@implementation CSLoginUser

- (NSDictionary *)dictionaryValue{
    return @{@"access_token":self.access_token,
             @"expires_in" : @(self.expires_in),
             @"isRealName" : @(self.isRealName),
             @"uid":@(self.uid)
             };
}

- (NSString *)description{
    return [NSString stringWithFormat:@"token: %@ \n uid: %@\n  realName:%@",self.access_token,@(self.uid),@(self.isRealName)];
}
@end
