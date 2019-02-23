//
//  CSLoginUserManager.m
//  CSinaWeibo
//
//  Created by 🐙怪兽 on 2019/2/22.
//  Copyright © 2019 com.😈. All rights reserved.
//

#import "CSLoginUserManager.h"
#import "CSLoginUser.h"

@interface CSLoginUserManager ()
@property(nonatomic,strong) NSUserDefaults *defaults;
@end

NSString *const UserExpiresNotification = @"UserExpiresNotification";
static NSString *const k_LoginedUserKEY = @"login user array key";

@implementation CSLoginUserManager
@synthesize currentUser = _currentUser;

SingleImplementation(UserManager)

- (instancetype)init{
    if (self = [super init]) {

        [[NSNotificationCenter defaultCenter] addObserverForName:UserExpiresNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
            [self.defaults removeObjectForKey:k_LoginedUserKEY];
            [self.defaults synchronize];
            self.currentUser = nil;
        }];
    }
    return self;
}

- (void)setCurrentUser:(CSLoginUser *)currentUser{
    if (![_currentUser.access_token isEqualToString:currentUser.access_token]) {
        _currentUser = currentUser;

        //归档
        NSDictionary *json = currentUser.dictionaryValue;
        [self.defaults setObject:json forKey:k_LoginedUserKEY];
        [self.defaults synchronize];
    }
}
- (CSLoginUser *)currentUser{
    if (!_currentUser) {
        NSDictionary *json = [self.defaults valueForKey:k_LoginedUserKEY];
        if (json) {
            _currentUser = [CSLoginUser instanceWithDict:json];
        }
    }
    return _currentUser;
}

- (NSUserDefaults *)defaults{
    return [NSUserDefaults standardUserDefaults];
}
@end
