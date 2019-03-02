//
//  CSNewStatusCell.m
//  CSinaWeibo
//
//  Created by 🐙怪兽 on 2019/2/24.
//  Copyright © 2019 com.😈. All rights reserved.
//

#import <Masonry.h>
#import <UIImageView+WebCache.h>
#import <AVKit/AVKit.h>

#import "CSNewStatusCell.h"
#import "CSStatus.h"
#import "NSString+CSExtension.h"

@interface CSNewStatusCell ()
@property(nonatomic,strong) UIImageView *imageView;
@property(nonatomic,strong) UILabel *nameLabel;
@property(nonatomic,strong) UILabel *subtitleLabel;

@property(nonatomic,strong) UITextView *textView;
@property(nonatomic,strong) UICollectionView *imageColletionView;
@property(nonatomic,strong) UIStackView *stackView;
@property(nonatomic,strong) AVPlayerViewController *avPlayerViewController;

@property(nonatomic,strong) CSStatus *status;
@end


@implementation CSNewStatusCell{
    CGFloat cellWidth;
    CGFloat spacing;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {

        // 默认rect
        spacing = 8.0f;
        cellWidth = CGRectGetWidth([UIScreen mainScreen].bounds) - spacing*2;

        CGRect rect = CGRectZero;
        // top viewes
        _imageView = [[UIImageView alloc] initWithFrame:rect];
        _nameLabel = [[UILabel alloc] initWithFrame:rect];
        _subtitleLabel = [[UILabel alloc] initWithFrame:rect];

        // bottom button
      
        [_imageView.layer setCornerRadius:25];
        [_imageView setClipsToBounds:YES];

        [_subtitleLabel setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleFootnote]];
        [_subtitleLabel setTextColor:UIColor.grayColor];

        _textView = [[UITextView alloc] initWithFrame:rect];
        [_textView setScrollEnabled:NO];
        [_textView setEditable:NO];
        [_textView setBackgroundColor:[UIColor colorWithWhite:1 alpha:0]];

        [_textView setAutoresizingMask:UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleWidth];

        
        [self.contentView addSubview:_imageView];
        [self.contentView addSubview:_nameLabel];
        [self.contentView addSubview:_subtitleLabel];
        [self.contentView addSubview:_textView];

        [self.layer setCornerRadius:8];
        [self setClipsToBounds:YES];
        [self setBackgroundColor:UIColor.whiteColor];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];

    static UIEdgeInsets inserts;
    inserts = UIEdgeInsetsMake(spacing, spacing, spacing, spacing);
    __weak typeof(self) weakSelf = self;

    CGFloat w = 50;
    CGFloat h = w;
    [_imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(weakSelf.contentView).insets(inserts);
        make.size.mas_equalTo(CGSizeMake(w, h));
    }];

    [_nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakSelf.imageView.mas_centerY);
        make.left.mas_equalTo(weakSelf.imageView.mas_right).insets(inserts);
        make.width.mas_equalTo(300);
    }];
    [_subtitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.nameLabel.mas_bottom).insets(inserts);
        make.left.right.mas_equalTo(weakSelf.nameLabel);
    }];
    [_textView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(weakSelf.contentView).insets(inserts);
        make.top.mas_equalTo(weakSelf.imageView.mas_bottom).insets(inserts);
        //make.bottom.mas_lessThanOrEqualTo(weakSelf.contentView.mas_bottom);
    }];

}

- (void)configureCellWith:(CSStatus *)status{
    self.status = status;

    self.nameLabel.text = status.user.name;
    self.subtitleLabel.text = status.user.location;

     NSString *text = status.text ;
    if (status.retweeted_status) {
//        NSString *userName = [NSString stringWithFormat:@"@%@",status.retweeted_status.user.name];
//        NSDictionary *att = @{NSForegroundColorAttributeName:UIColor.blueColor};

        NSAttributedString *attName = [status.retweeted_status.user.name userInfoString];

        NSString *rew = [NSString stringWithFormat:@"%@",status.retweeted_status.text];

        NSMutableAttributedString *mAtt = [[NSMutableAttributedString alloc] initWithString:text];
        [mAtt appendAttributedString:attName];
        [mAtt appendAttributedString:[[NSAttributedString alloc] initWithString:rew]];
        self.textView.attributedText = mAtt;

    }else{
        self.textView.text = text;
    }


    NSString *url = status.user.profile_image_url;
    //替换参数
    NSRange rang = [url rangeOfString:@".50"];
    NSString *sub = [url substringWithRange:rang];
    CGFloat w = CGRectGetWidth(self.imageView.bounds)*[UIScreen mainScreen].scale;
    NSString *withString = [NSString stringWithFormat:@".%.1f",w];
    url = [url stringByReplacingOccurrencesOfString:sub withString:withString];

    [self.imageView sd_setImageWithURL:[NSURL URLWithString:url] completed:nil];

    [self setNeedsLayout];
}


- (UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes{
    UICollectionViewLayoutAttributes *att = [super preferredLayoutAttributesFittingAttributes:layoutAttributes];
//
//    CGFloat w = CGRectGetWidth([UIScreen mainScreen].bounds) - 16;
    CGSize size = att.size;
    size.width = cellWidth;
    att.size = size;
    NSLog(@"H =%f",size.height);


    return att;
}

//-(CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize
//       withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority
//    return CGSizeMake(398, 200);
//}
//- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes{
//
//}


@end
