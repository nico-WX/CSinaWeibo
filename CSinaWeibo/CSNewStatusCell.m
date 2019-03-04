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

//data
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
    inserts = UIEdgeInsetsMake(spacing, spacing, spacing, spacing);
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


    [self.textView setAttributedText:status.allText];

    if (status.pic_urls.count > 0) {

        NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc] initWithAttributedString:self.textView.attributedText];

        __weak typeof(self) weakSelf = self;
        for (NSDictionary *urlDict in status.pic_urls) {

            NSString *url = [[urlDict allValues] lastObject];

            [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:url] options:(SDWebImageDownloaderProgressiveDownload|SDWebImageDownloaderContinueInBackground) progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
            } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {

                NSTextAttachment *attachement =[[NSTextAttachment alloc] init];
                attachement.image = image;
                attachement.bounds = CGRectMake(0, 0, 120, 120);
                NSAttributedString *imageString = [NSAttributedString  attributedStringWithAttachment:attachement];
                NSMutableAttributedString *mutableAttributedString = [[NSMutableAttributedString alloc] initWithAttributedString:imageString];
                [mutableAttributedString addAttributes:@{NSAttachmentAttributeName:imageString} range:(NSMakeRange(0, imageString.length))];
                [attributed appendAttributedString:mutableAttributedString];

                //[attributed addAttribute:NSAttachmentAttributeName value:imageString range:NSMakeRange(attributed.string.length, 1)];
                weakSelf.textView.attributedText = attributed;
                NSLog(@"text att =%@",weakSelf.textView.attributedText);
            }];
        }
    }

    [self setNeedsLayout];
}


- (UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes{
    UICollectionViewLayoutAttributes *att = [super preferredLayoutAttributesFittingAttributes:layoutAttributes];

    CGSize size = att.size;
    size.width = cellWidth;
    att.size = size;
    return att;
}

@end
