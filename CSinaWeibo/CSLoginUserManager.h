//
//  CSLoginUserManager.h
//  CSinaWeibo
//
//  Created by 🐙怪兽 on 2019/2/22.
//  Copyright © 2019 com.😈. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Single.h"
@class CSLoginUser;


extern NSString *const UserExpiresNotification;

@interface CSLoginUserManager : NSObject

@property(nonatomic,strong) CSLoginUser *currentUser; // 当前用户
SingleInterface(UserManager);


@end


