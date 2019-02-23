//
//  CSResponseRoot.h
//  CSinaWeibo
//
//  Created by 🐙怪兽 on 2019/2/23.
//  Copyright © 2019 com.😈. All rights reserved.
//

#import "CSBaseModel.h"
#import "CSStatus.h"

NS_ASSUME_NONNULL_BEGIN

@interface CSResponseRoot : CSBaseModel
@property(nonatomic,strong) NSArray<CSStatus*> *statuses; //
@property(nonatomic,assign) BOOL hasvisible;
@property(nonatomic,assign) NSUInteger previous_cursor;
@property(nonatomic,assign) NSUInteger next_cursor;
@property(nonatomic,assign) NSUInteger total_number;
@property(nonatomic,assign) NSUInteger interval;

@end

NS_ASSUME_NONNULL_END
