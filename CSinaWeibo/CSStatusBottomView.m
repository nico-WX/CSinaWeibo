//
//  CSStatusBottomView.m
//  CSinaWeibo
//
//  Created by 🐙怪兽 on 2019/3/2.
//  Copyright © 2019 com.😈. All rights reserved.
//

#import "CSStatusBottomView.h"
#import <Masonry.h>

@interface CSStatusBottomView ()
@property(nonatomic,strong)UIStackView *stackView;
@end
@implementation CSStatusBottomView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _stackView = [[UIStackView alloc] init];
        [_stackView setAxis:UILayoutConstraintAxisHorizontal];
        [_stackView setSpacing:2.0f];
        [_stackView setDistribution:UIStackViewDistributionFillEqually];
        [_stackView setTranslatesAutoresizingMaskIntoConstraints:NO];

        _forward = [[UIButton alloc] init];
        _comment = [[UIButton alloc] init];
        _praise = [[UIButton alloc] init];
        [_forward setTitle:@"转发" forState:UIControlStateNormal];
        [_comment setTitle:@"评论" forState:UIControlStateNormal];
        [_praise setTitle:@"点赞👍" forState:UIControlStateNormal];
        [_forward setTitleColor:UIColor.grayColor forState:UIControlStateNormal];
        [_comment setTitleColor:UIColor.grayColor forState:UIControlStateNormal];
        [_praise setTitleColor:UIColor.grayColor forState:UIControlStateNormal];


        [_stackView addArrangedSubview:_forward];
        [_stackView addArrangedSubview:_comment];
        [_stackView addArrangedSubview:_praise];

        [self addSubview:_stackView];
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];

    __weak typeof(self) weakSelf = self;
    [_stackView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf);
    }];
}

@end
