//
//  CSNewStatusCell.m
//  CSinaWeibo
//
//  Created by 🐙怪兽 on 2019/2/24.
//  Copyright © 2019 com.😈. All rights reserved.
//

#import <Masonry.h>
#import <UIImageView+WebCache.h>
#import <UIImage+YYAdd.h>
#import <SDWebImageDownloader.h>
#import <AVKit/AVKit.h>

#import "CSNewStatusCell.h"
#import "CSStatus.h"
#import "NSString+CSExtension.h"
#import "CSStatusBottomView.h"

@interface CSNewStatusCell ()<UITextViewDelegate>
@property(nonatomic,strong) UIImageView *imageView;
@property(nonatomic,strong) UILabel *nameLabel;
@property(nonatomic,strong) UILabel *subtitleLabel;

@property(nonatomic,assign) CGFloat cellWidth;
@property(nonatomic,assign) CGFloat spacing;

//data
@property(nonatomic,strong) CSStatus *status;
@end


@implementation CSNewStatusCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {

        // 默认rect
        _spacing = 8.0f;
        _cellWidth = CGRectGetWidth([UIScreen mainScreen].bounds) - _spacing*2;

        CGRect rect = CGRectZero;
        // top viewes
        _imageView = [[UIImageView alloc] initWithFrame:rect];
        _nameLabel = [[UILabel alloc] initWithFrame:rect];
        _subtitleLabel = [[UILabel alloc] initWithFrame:rect];

        // text/collectionView/avPlayer
        _textView = [[UITextView alloc] initWithFrame:rect];
        

        // bottom button
        _bottomView = [[CSStatusBottomView alloc] initWithFrame:rect];
      
        [_imageView.layer setCornerRadius:25];
        [_imageView setClipsToBounds:YES];

        [_subtitleLabel setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleFootnote]];
        [_subtitleLabel setTextColor:UIColor.grayColor];


        [_textView setScrollEnabled:NO];
        [_textView setEditable:NO];
        [_textView setBackgroundColor:[UIColor colorWithWhite:1 alpha:0]];
        [_textView setAutoresizingMask:UIViewAutoresizingFlexibleBottomMargin];
        [_textView setDataDetectorTypes:UIDataDetectorTypeLink];
        [_textView setDelegate:self];

        
        [self.contentView addSubview:_imageView];
        [self.contentView addSubview:_nameLabel];
        [self.contentView addSubview:_subtitleLabel];
        [self.contentView addSubview:_textView];
        [self.contentView addSubview:_bottomView];

        [self.layer setCornerRadius:8];
        [self setClipsToBounds:YES];
        [self setBackgroundColor:UIColor.whiteColor];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];

    static UIEdgeInsets inserts;
    inserts = UIEdgeInsetsMake(_spacing, _spacing, _spacing, _spacing);
    __weak typeof(self) weakSelf = self;

    CGFloat w = 50;
    CGFloat h = w;
    // top info
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

    // bottom button stack
    [_bottomView mas_remakeConstraints:^(MASConstraintMaker *make){
        make.left.bottom.right.mas_equalTo(weakSelf.contentView);
        make.height.mas_equalTo(30.0f);
    }];

    // 中间伸缩内容
    [_textView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(weakSelf.contentView).insets(inserts);
        make.top.mas_equalTo(weakSelf.imageView.mas_bottom).insets(inserts);
        make.bottom.mas_equalTo(weakSelf.bottomView.mas_top);
    }];

}

- (void)configureCellWith:(CSStatus *)status{
    self.status = status;

    // top info
    self.nameLabel.text = status.user.name;
    self.subtitleLabel.text = status.user.location;
    // profile image
    NSString *url = status.user.profile_image_url;
    //替换参数
    NSRange rang = [url rangeOfString:@".50"];
    NSString *sub = [url substringWithRange:rang];
    CGFloat w = CGRectGetWidth(self.imageView.bounds)*[UIScreen mainScreen].scale;
    NSString *withString = [NSString stringWithFormat:@".%.1f",w];
    url = [url stringByReplacingOccurrencesOfString:sub withString:withString];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:url] completed:nil];

    //text content
    [self.textView setAttributedText:status.allText];

    // image content
    if (status.pic_urls.count > 0 || status.retweeted_status.pic_urls.count > 0) {

        NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc] initWithAttributedString:self.textView.attributedText];
        [attributed appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];

        __weak typeof(self) weakSelf = self;
        //下载图片
        dispatch_apply([status.pic_urls count], dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(size_t index) {
            NSDictionary *urlDict = status.pic_urls[index];     // 图片键值对象
            NSString *url = [[urlDict allValues] lastObject];   // 值URL

            dispatch_async(dispatch_get_main_queue(), ^{
                [[UIImageView new] sd_setImageWithURL:[NSURL URLWithString:url] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                    //照片附加
                    NSTextAttachment *attachement =[[NSTextAttachment alloc] init];
                    attachement.image = image;
                    CGFloat w = (weakSelf.cellWidth-6)/3;
                    attachement.bounds = CGRectMake(0, 0, w, w);
                    NSAttributedString *imageString = [NSAttributedString  attributedStringWithAttachment:attachement];

                    //追加图片在后面
                    [attributed appendAttributedString:imageString];
                    //交互
                    [attributed setAttributes:@{NSAttachmentAttributeName:attachement} range:NSMakeRange(attributed.string.length, 0)];
                    weakSelf.textView.attributedText = attributed;

                    NSLog(@"iamge ====%@",image);
                    [self setNeedsLayout];
                    [self setNeedsDisplay];
                }];
            });
        });
    }
    [self setNeedsLayout];
}


- (UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes{
    UICollectionViewLayoutAttributes *att = [super preferredLayoutAttributesFittingAttributes:layoutAttributes];

    CGSize size = att.size;
    size.width = self.cellWidth;
    att.size = size;
    return att;
}

@end
