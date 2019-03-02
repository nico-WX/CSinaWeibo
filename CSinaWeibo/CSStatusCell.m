//
//  CSStatusCell.m
//  CSinaWeibo
//
//  Created by 🐙怪兽 on 2019/2/23.
//  Copyright © 2019 com.😈. All rights reserved.
//

#import "CSStatusCell.h"
#import "CSStatus.h"
#import <UIImageView+WebCache.h>


@implementation CSStatusCell

- (void)awakeFromNib{
    [super awakeFromNib];

    CGFloat corner = CGRectGetHeight(self.imageView.bounds)/2;
    [self.imageView.layer setCornerRadius:corner];
    [self.imageView setClipsToBounds:YES];

    [self.layer setCornerRadius:6];
    [self setClipsToBounds:YES];


}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {

    }
    return self;
}

- (void)configureCellWith:(CSStatus *)status{
    self.statusNameLabel.text = status.user.name;
    self.statusSubtitleLabel.text = status.user.location;
    self.TextContentLabel.text = status.text;
    

    NSString *url = status.user.profile_image_url;
    //替换参数
    NSRange rang = [url rangeOfString:@".50"];
    NSString *sub = [url substringWithRange:rang];
    CGFloat w = CGRectGetWidth(self.imageView.bounds)*[UIScreen mainScreen].scale;
    NSString *withString = [NSString stringWithFormat:@".%.1f",w];
    url = [url stringByReplacingOccurrencesOfString:sub withString:withString];

    [self.imageView sd_setImageWithURL:[NSURL URLWithString:url] completed:nil];

}
@end
