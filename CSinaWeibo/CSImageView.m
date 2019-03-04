//
//  CSImageView.m
//  CSinaWeibo
//
//  Created by 🐙怪兽 on 2019/2/24.
//  Copyright © 2019 com.😈. All rights reserved.
//

#import "CSImageView.h"
#import <Masonry.h>
#import <AVKit/AVKit.h>

@interface CSImageView ()
@end

static CGFloat const spacing = 4.0;
static CGFloat const w = 100;
static CGFloat const h = 100;

@implementation CSImageView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _playerViewController = [[AVPlayerViewController alloc] init];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];

    static UIEdgeInsets inserts;
    inserts = UIEdgeInsetsMake(spacing, spacing, spacing, spacing);
    __weak typeof(self) weakSelf = self;

}


@end
