//
//  CSBaseModel.h
//  CSinaWeibo
//
//  Created by 🐙怪兽 on 2019/2/22.
//  Copyright © 2019 com.😈. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MJExtension.h>

NS_ASSUME_NONNULL_BEGIN

@interface CSBaseModel : NSObject
- (instancetype)initWithDict:(NSDictionary*)dict;
+ (instancetype)instanceWithDict:(NSDictionary*)dict;
@end

NS_ASSUME_NONNULL_END
