//
//  CSImageView.h
//  CSinaWeibo
//
//  Created by 🐙怪兽 on 2019/2/24.
//  Copyright © 2019 com.😈. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AVPlayerViewController;
NS_ASSUME_NONNULL_BEGIN

@interface CSImageView : UIView
@property(nonatomic,strong,readonly) AVPlayerViewController *playerViewController;
@property(nonatomic,strong,readonly) NSArray<UIImage*> *images;

@property(nonatomic,strong) NSArray<NSString*> *imageArray;

@end

NS_ASSUME_NONNULL_END
