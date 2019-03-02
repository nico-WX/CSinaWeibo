//
//  CSBaseViewController.m
//  CSinaWeibo
//
//  Created by 🐙怪兽 on 2019/2/23.
//  Copyright © 2019 com.😈. All rights reserved.
//

#import "CSBaseViewController.h"
#import "CSLoginUserManager.h"
#import "LoginViewController.h"


@interface CSBaseViewController ()
@end

@implementation CSBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(currentUser) name:TokenForbiddenNotification object:nil];
}

- (CSLoginUser *)currentUser{

    NSLog(@"noti");
    CSLoginUser *user = [CSLoginUserManager shareUserManager].currentUser;
    if (!user && user.access_token.length > 0) {
        LoginViewController *login = [LoginViewController new];
        [self presentViewController:login animated:YES completion:nil];
    }
    return user;
}


@end
