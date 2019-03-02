//
//  CSStatusBottomView.h
//  CSinaWeibo
//
//  Created by 🐙怪兽 on 2019/3/2.
//  Copyright © 2019 com.😈. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CSStatusBottomView : UIView
@property(nonatomic,strong,readonly)UIButton *forward;  //转发
@property(nonatomic,strong,readonly)UIButton *comment;  //评论
@property(nonatomic,strong,readonly)UIButton *praise;   //点赞
@end

NS_ASSUME_NONNULL_END
