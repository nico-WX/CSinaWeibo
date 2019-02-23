//
//  CSTabBarController.m
//  CSinaWeibo
//
//  Created by 🐙怪兽 on 2019/2/23.
//  Copyright © 2019 com.😈. All rights reserved.
//

#import "CSTabBarController.h"
#import "CSHomeViewController.h"

@interface CSTabBarController ()

@end

@implementation CSTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    CSHomeViewController *home = [[CSHomeViewController alloc] init];
    [home setTitle:@"主页"];
    [self addChildViewController:home];
}


@end
