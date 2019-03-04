//
//  CSStatus.m
//  CSinaWeibo
//
//  Created by 🐙怪兽 on 2019/2/23.
//  Copyright © 2019 com.😈. All rights reserved.
//

#import "CSStatus.h"
#import <UIKit/UIKit.h>

@implementation CSStatus

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"identifier":@"id"};
}

- (NSAttributedString *)allText{
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:self.text];

    if (self.retweeted_status) {
        NSString *name = [NSString stringWithFormat:@"@%@",self.retweeted_status.user.name];
        NSDictionary *attributesDict = @{NSForegroundColorAttributeName:UIColor.blueColor,
                                         NSLinkAttributeName:self.retweeted_status.user.identifier,
                                         };

        NSMutableAttributedString *userName = [[NSMutableAttributedString alloc] initWithString:name attributes:attributesDict];
        [userName insertAttributedString:[[NSAttributedString alloc] initWithString:@"//"] atIndex:0];

        NSString *text = [NSString stringWithFormat:@" %@",self.retweeted_status.text];
        [userName appendAttributedString:[[NSAttributedString alloc] initWithString:text]];
        [att appendAttributedString:userName];

    }

   return att;
}
@end
