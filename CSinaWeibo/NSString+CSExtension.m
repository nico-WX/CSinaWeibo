//
//  NSString+CSExtension.m
//  CSinaWeibo
//
//  Created by 🐙怪兽 on 2019/2/25.
//  Copyright © 2019 com.😈. All rights reserved.
//

#import "NSString+CSExtension.h"
#import <UIKit/UIKit.h>

@implementation NSString (CSExtension)

- (NSAttributedString *)userInfoString{
    /**
     NSString *userName = [NSString stringWithFormat:@"@%@",status.retweeted_status.user.name];
     NSDictionary *att = @{NSForegroundColorAttributeName:UIColor.blueColor};
     NSAttributedString *attName = [[NSAttributedString alloc] initWithString:userName attributes:attName];

     */
    NSString *userName = [NSString stringWithFormat:@"@%@",self];
    NSDictionary *att = @{NSForegroundColorAttributeName:UIColor.blueColor,
                          };


    return [[NSAttributedString alloc] initWithString:userName attributes:att];
}

@end
