//
//  CSImageView.m
//  CSinaWeibo
//
//  Created by 🐙怪兽 on 2019/2/24.
//  Copyright © 2019 com.😈. All rights reserved.
//

#import "CSImageView.h"
#import <Masonry.h>

@interface CSImageView ()
@property(nonatomic,strong) UIStackView *vStackView;
@end

static CGFloat const spacing = 4.0;

static CGFloat const w = 100;
static CGFloat const h = 100;
@implementation CSImageView


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _vStackView = [[UIStackView alloc] init];
        [_vStackView setSpacing:spacing];
        [_vStackView setDistribution:UIStackViewDistributionFillEqually];

        [self addSubview:_vStackView];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];

    static UIEdgeInsets inserts;
    inserts = UIEdgeInsetsMake(spacing, spacing, spacing, spacing);

    __weak typeof(self) weakSelf = self;
    [_vStackView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf).insets(inserts);
    }];
}

- (void)setImageArray:(NSArray<NSString *> *)imageArray{
    if (_imageArray != imageArray) {
        _imageArray = imageArray;

        for (NSString *path in imageArray) {
            
        }
    }
}

@end
