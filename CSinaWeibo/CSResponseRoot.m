//
//  CSResponseRoot.m
//  CSinaWeibo
//
//  Created by 🐙怪兽 on 2019/2/23.
//  Copyright © 2019 com.😈. All rights reserved.
//

#import "CSResponseRoot.h"

@implementation CSResponseRoot

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"statuses":@"CSStatus"};
}
@end
