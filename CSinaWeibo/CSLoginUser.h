//
//  CSLoginUser.h
//  CSinaWeibo
//
//  Created by 🐙怪兽 on 2019/2/22.
//  Copyright © 2019 com.😈. All rights reserved.
//

#import "CSBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CSLoginUser : CSBaseModel
@property(nonatomic,copy,  readonly) NSString *access_token;
@property(nonatomic,assign,readonly) NSUInteger expires_in;
@property(nonatomic,assign,readonly) NSUInteger uid;
@property(nonatomic,assign,readonly) BOOL isRealName;

/**转换为字典, 存储*/ 
- (NSDictionary*)dictionaryValue;
@end

NS_ASSUME_NONNULL_END
