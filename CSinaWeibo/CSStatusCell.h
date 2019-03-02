//
//  CSStatusCell.h
//  CSinaWeibo
//
//  Created by 🐙怪兽 on 2019/2/23.
//  Copyright © 2019 com.😈. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CSStatus;

NS_ASSUME_NONNULL_BEGIN

@interface CSStatusCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *statusNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusSubtitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *TextContentLabel;


- (void)configureCellWith:(CSStatus*)status;
@end

NS_ASSUME_NONNULL_END
