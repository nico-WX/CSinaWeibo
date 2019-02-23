//
//  CSUser.h
//  CSinaWeibo
//
//  Created by 🐙怪兽 on 2019/2/23.
//  Copyright © 2019 com.😈. All rights reserved.
//

#import "CSBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CSUser : CSBaseModel

@property(nonatomic,copy) NSString *identifier; // "id": 5768659583,
@property(nonatomic,copy) NSString *idstr;
@property(nonatomic,copy) NSString *userClass; //  "class": 1,
@property(nonatomic,copy) NSString *screen_name;
@property(nonatomic,copy) NSString *name;
@property(nonatomic,strong) NSNumber *province;
@property(nonatomic,strong) NSNumber *city;
@property(nonatomic,copy) NSString *location;
@property(nonatomic,copy) NSString *userDescription; //  description;
@property(nonatomic,copy) NSString *url;
@property(nonatomic,copy) NSString *profile_image_url;
@property(nonatomic,copy) NSString *cover_image_phone;
@property(nonatomic,copy) NSString *profile_url;
@property(nonatomic,copy) NSString *domain;
@property(nonatomic,copy) NSString *weihao;
@property(nonatomic,copy) NSString *gender;
@property(nonatomic,strong) NSNumber *followers_count;
@property(nonatomic,strong) NSNumber *friends_count;
@property(nonatomic,strong) NSNumber *pagefriends_count;
@property(nonatomic,strong) NSNumber *statuses_count;
@property(nonatomic,strong) NSNumber *video_status_count;
@property(nonatomic,strong) NSNumber *favourites_count;
@property(nonatomic,copy) NSString *created_at;
@property(nonatomic,assign) BOOL following;
@property(nonatomic,assign) BOOL allow_all_act_msg;
@property(nonatomic,assign) BOOL geo_enabled;
@property(nonatomic,assign) BOOL verified;
@property(nonatomic,strong) NSNumber *verified_type;
@property(nonatomic,copy) NSString *remark;
@property(nonatomic,strong) NSDictionary *insecurity;
@property(nonatomic,strong) NSNumber *ptype;
@property(nonatomic,assign) BOOL allow_all_comment;
@property(nonatomic,copy) NSString *avatar_large;
@property(nonatomic,copy) NSString *avatar_hd;
@property(nonatomic,copy) NSString *verified_reason;
@property(nonatomic,copy) NSString *verified_trade;
@property(nonatomic,copy) NSString *verified_reason_url;
@property(nonatomic,copy) NSString *verified_source;
@property(nonatomic,copy) NSString *verified_source_url;
@property(nonatomic,strong) NSNumber *verified_state;
@property(nonatomic,strong) NSNumber *verified_level;
@property(nonatomic,strong) NSNumber *verified_type_ext;
@property(nonatomic,assign) BOOL has_service_tel;
@property(nonatomic,copy) NSString *verified_reason_modified;
@property(nonatomic,copy) NSString *verified_contact_name;
@property(nonatomic,copy) NSString *verified_contact_email;
@property(nonatomic,copy) NSString *verified_contact_mobile;
@property(nonatomic,assign) BOOL follow_me;
@property(nonatomic,assign) BOOL like;
@property(nonatomic,assign) BOOL like_me;
@property(nonatomic,strong) NSNumber *online_status;
@property(nonatomic,strong) NSNumber *bi_followers_count;
@property(nonatomic,copy) NSString *lang;
@property(nonatomic,strong) NSNumber *star;
@property(nonatomic,strong) NSNumber *mbtype;
@property(nonatomic,strong) NSNumber *mbrank;
@property(nonatomic,strong) NSNumber *block_word;
@property(nonatomic,strong) NSNumber *block_app;
@property(nonatomic,strong) NSNumber *credit_score;
@property(nonatomic,strong) NSNumber *user_ability;
@property(nonatomic,copy) NSString *cardid;
@property(nonatomic,copy) NSString *avatargj_id;
@property(nonatomic,copy) NSString *urank;
@property(nonatomic,strong) NSNumber *story_read_state;
@property(nonatomic,strong) NSNumber *vclub_member;
@property(nonatomic,strong) NSNumber *is_teenager;
@property(nonatomic,strong) NSNumber *is_guardian;
@property(nonatomic,strong) NSNumber *is_teenager_list;

@end

NS_ASSUME_NONNULL_END
