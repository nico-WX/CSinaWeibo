//
//  CSNewStatusCell.h
//  CSinaWeibo
//
//  Created by 🐙怪兽 on 2019/2/24.
//  Copyright © 2019 com.😈. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AVPlayerViewController;
@class CSStatusBottomView;

@class CSStatus;

@interface CSNewStatusCell : UICollectionViewCell

@property(nonatomic,strong,readonly) UITextView *textView;
@property(nonatomic,strong,readonly) AVPlayerViewController *avPlayerViewController;
@property(nonatomic,strong,readonly) CSStatusBottomView *bottomView;

- (void)configureCellWith:(CSStatus *)status;
@end

