//
//  CSBaseViewController.h
//  CSinaWeibo
//
//  Created by 🐙怪兽 on 2019/2/23.
//  Copyright © 2019 com.😈. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSLoginUser.h"

@interface CSBaseViewController : UIViewController
@property(nonatomic,strong,readonly) CSLoginUser *currentUser;

//- (void)loginNewUser;
@end


