//
//  CSStatus.h
//  CSinaWeibo
//
//  Created by 🐙怪兽 on 2019/2/23.
//  Copyright © 2019 com.😈. All rights reserved.
//

#import "CSBaseModel.h"
#import "CSUser.h"

NS_ASSUME_NONNULL_BEGIN


@interface CSStatus : CSBaseModel

@property(nonatomic,copy)NSString *created_at;

@property(nonatomic,strong) NSNumber *identifier; //>> id
@property(nonatomic,copy) NSString *idstr;
@property(nonatomic,copy) NSString *mid;

@property(nonatomic,assign)BOOL can_edit;
@property(nonatomic,assign)BOOL show_additional_indication;

@property(nonatomic,copy) NSString *text;   //"text": "我用饭票兑换了@明星势力榜 鲜花1朵，送给@斯外戈 ，你也快来兑换吧！ http://t.cn/RkJdeo7 ​",
@property(nonatomic,strong)NSNumber *textLength;
@property(nonatomic,assign)BOOL source_allowclick;
@property(nonatomic,strong)NSNumber *source_type;
@property(nonatomic,copy)NSString *source;  //"<a href=\"http://app.weibo.com/t/feed/5oDlPE\" rel=\"nofollow\">饭票</a>",
@property(nonatomic,assign)BOOL favorited;
@property(nonatomic,assign)BOOL truncated;
@property(nonatomic,copy) NSString *in_reply_to_status_id;
@property(nonatomic,copy) NSString *in_reply_to_user_id;
@property(nonatomic,copy) NSString *in_reply_to_screen_name;
@property(nonatomic,strong) NSArray *pic_urls;
@property(nonatomic,strong) NSString *geo;
@property(nonatomic,assign) BOOL is_paid;
@property(nonatomic,strong) NSNumber *mblog_vip_type;

@property(nonatomic,strong) CSUser *user;

@property(nonatomic,strong) NSNumber *reposts_count;
@property(nonatomic,strong) NSNumber *comments_count;
@property(nonatomic,strong) NSNumber *attitudes_count;
@property(nonatomic,strong) NSNumber *pending_approval_count;
@property(nonatomic,assign) BOOL isLongText;
@property(nonatomic,strong) NSNumber *reward_exhibition_type;
@property(nonatomic,assign) BOOL hide_flag;
@property(nonatomic,strong) NSNumber *mlevel;
@property(nonatomic,strong) NSDictionary *visible;
@property(nonatomic,strong) NSNumber *biz_feature;
@property(nonatomic,strong) NSNumber *hasActionTypeCard;
@property(nonatomic,strong) NSArray *darwin_tags;
@property(nonatomic,strong) NSArray *hot_weibo_tags;
@property(nonatomic,strong) NSArray *text_tag_tips;
@property(nonatomic,strong) NSNumber *mblogtype;
@property(nonatomic,strong) NSNumber *userType;
@property(nonatomic,strong) NSNumber *more_info_type;
@property(nonatomic,copy) NSString *cardid;
@property(nonatomic,strong) NSDictionary *number_display_strategy;
@property(nonatomic,strong) NSNumber *positive_recom_flag;
@property(nonatomic,strong) NSNumber *content_auth;
@property(nonatomic,strong) NSNumber *gif_ids;
@property(nonatomic,strong) NSNumber *is_show_bulletin;
@property(nonatomic,strong) NSDictionary *comment_manage_info;

@property(nonatomic,strong) NSDictionary *url_short;

//转发
@property(nonatomic,strong) CSStatus *retweeted_status;

@property(nonatomic,copy)NSAttributedString *allText;
@end

NS_ASSUME_NONNULL_END
