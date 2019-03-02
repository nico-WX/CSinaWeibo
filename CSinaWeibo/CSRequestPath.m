//
//  CSRequestPath.m
//  CSinaWeibo
//
//  Created by 🐙怪兽 on 2019/2/23.
//  Copyright © 2019 com.😈. All rights reserved.
//

#import "CSRequestPath.h"


@interface CSRequestPath()

@property(nonatomic, strong) NSURLComponents *components;
@property(nonatomic, strong) NSURLQueryItem *tokenQuery;
@end


static NSString *const accessToken = @"2.00AZDAcH6NFl6B1af85e1942wkBjSC";

@implementation CSRequestPath

- (instancetype)init{
    if (self = [super init]) {

        _components = [[NSURLComponents alloc] init];
        [_components setScheme:@"https"];
        [_components setHost:@"api.weibo.com"];
        [_components setPath:@"/2"];

        _tokenQuery = [NSURLQueryItem queryItemWithName:@"access_token" value:accessToken];
        //NSLog(@"url =%@",_components.URL);
    }
    return self;
}


// 获取当前登录用户及其所关注用户的最新微博
- (NSURLRequest *)home_TimeLine{

    self.components.path =  [_components.path stringByAppendingPathComponent:@"statuses/home_timeline.json"];
    NSURLQueryItem *count = [NSURLQueryItem queryItemWithName:@"count" value:@"100"];
    self.components.queryItems = @[_tokenQuery,count];

    NSLog(@"url =====%@",self.components.URL);
    return [NSURLRequest requestWithURL:self.components.URL];
}

//获取用户发布的微博
- (NSURLRequest *)user_TimeLine{
    self.components.path =  [_components.path stringByAppendingPathComponent:@"statuses/user_timeline.json"];
    self.components.queryItems = @[_tokenQuery,];

    return [NSURLRequest requestWithURL:self.components.URL];
}

//返回一条原创微博的最新转发微博
- (NSURLRequest *)repost_timeline{
    self.components.path = [_components.path stringByAppendingPathComponent:@"statuses/repost_timeline.json"];
    self.components.queryItems = @[_tokenQuery,];
    return [NSURLRequest requestWithURL:self.components.URL];
}

//获取@当前用户的最新微博
- (NSURLRequest *)mentions{
    self.components.path = [_components.path stringByAppendingPathComponent:@"statuses/mentions.json"];
    self.components.queryItems = @[_tokenQuery,];
    return [NSURLRequest requestWithURL:self.components.URL];
}


- (NSURLRequest *)short_url_expandWithShortURL:(NSString *)shortURL{

//  //https://api.weibo.com/2/short_url/expand.json?access_token=2.00AZDAcH6NFl6B1af85e1942wkBjSC&url_short=http://t.cn/EVkg9h2
    self.components.path = [_components.path stringByAppendingPathComponent:@"short_url/expand.json"];
    NSURLQueryItem *url_short = [NSURLQueryItem queryItemWithName:@"url_short" value:shortURL];
    self.components.queryItems = @[_tokenQuery,url_short];
    return [NSURLRequest requestWithURL:self.components.URL];
}



// statuses/show    根据ID获取单条微博信息
// statuses/count    批量获取指定微博的转发数评论数
// statuses/go    根据ID跳转到单条微博页
// emotions    获取官方表情
// statuses/share    第三方分享链接到微博

/**

 评论
 读取接口    comments/show    获取某条微博的评论列表
 comments/by_me    我发出的评论列表
 comments/to_me    我收到的评论列表
 comments/timeline    获取用户发送及收到的评论列表
 comments/mentions    获取@到我的评论
 comments/show_batch    批量获取评论内容
 写入接口    comments/create    评论一条微博
 comments/destroy    删除一条我的评论
 comments/destroy_batch    批量删除我的评论
 comments/reply    回复一条我收到的评论

 用户
 读取接口    users/show    获取用户信息
 users/domain_show    通过个性域名获取用户信息
 users/counts    批量获取用户的粉丝数、关注数、微博数
 关系
 关注读取接口    friendships/friends    获取用户的关注列表
 friendships/friends/ids    获取用户关注对象UID列表
 粉丝读取接口    friendships/followers    获取用户粉丝列表
 friendships/followers/ids    获取用户粉丝UID列表
 关系读取接口    friendships/show    获取两个用户之间是否存在关注关系
 搜索
 搜索话题接口    search/topics    搜索某一话题下的微博
 短链
 转换接口    short_url/shorten    长链转短链
 short_url/expand    短链转长链
 数据接口    short_url/share/counts    获取短链接在微博上的微博分享数
 short_url/comment/counts    获取短链接在微博上的微博评论数
 公共服务
 读取接口    common/code_to_location    通过地址编码获取地址名称
 common/get_city    获取城市列表
 common/get_province    获取省份列表
 common/get_country    获取国家列表
 common/get_timezone    获取时区配置表

 */

@end
