//
//  CSNewStatusCell.h
//  CSinaWeibo
//
//  Created by 🐙怪兽 on 2019/2/24.
//  Copyright © 2019 com.😈. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CSStatus;
NS_ASSUME_NONNULL_BEGIN

@interface CSNewStatusCell : UICollectionViewCell
- (void)configureCellWith:(CSStatus *)status;

@end

NS_ASSUME_NONNULL_END
