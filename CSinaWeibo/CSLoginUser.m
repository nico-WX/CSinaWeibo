//
//  CSUser.m
//  CSinaWeibo
//
//  Created by 🐙怪兽 on 2019/2/22.
//  Copyright © 2019 com.😈. All rights reserved.
//

#import "CSLoginUser.h"

static NSString *const k_accessTokenKEY = @"accessToken";
static NSString *const k_expiresKEY     = @"expires";
static NSString *const k_isRealNameKEY  = @"isRealName";
static NSString *const k_uidKEY         = @"uid";

@implementation CSLoginUser

- (NSDictionary *)dictionaryValue{
    return @{@"access_token":self.access_token,
             @"expires_in" : @(self.expires_in),
             @"isRealName" : @(self.isRealName),
             @"uid":@(self.uid)
             };
}


- (NSString *)description{
    return [NSString stringWithFormat:@"token:%@ \n uid: %@\n  realName:%@ exp =%@ \n",self.access_token,@(self.uid),@(self.isRealName),@(self.expires_in)];
}
@end
