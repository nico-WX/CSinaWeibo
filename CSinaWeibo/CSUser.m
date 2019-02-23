//
//  CSUser.m
//  CSinaWeibo
//
//  Created by 🐙怪兽 on 2019/2/23.
//  Copyright © 2019 com.😈. All rights reserved.
//

#import "CSUser.h"

@implementation CSUser
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"identifier":@"id",
             @"userClass":@"class",
             @"userDescription":@"description"
             };
}

@end
