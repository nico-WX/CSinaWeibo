//
//  CSAuthorizePath.m
//  CSinaWeibo
//
//  Created by 🐙怪兽 on 2019/2/22.
//  Copyright © 2019 com.😈. All rights reserved.
//

#import "CSAuthorizePath.h"

// key
static NSString *const app_Secret = @"7d70cc70bc0d652e37ddca3ac34b0d55";
static NSString *const client_id = @"1296762699";

//url
static NSString *const redirect_uri = @"https://api.weibo.com/oauth2/default.html";
static NSString *const authorizeURL = @"https://api.weibo.com/oauth2/authorize";  // get/post  return AuthCode
static NSString *const accessTokenURL = @"https://api.weibo.com/oauth2/access_token"; //post

@implementation CSAuthorizePath
@synthesize requestAuthorizePath = _requestAuthorizePath;

- (NSString *)requestAuthorizePath{
    if (!_requestAuthorizePath) {
        NSString *path = [authorizeURL stringByAppendingString:[NSString stringWithFormat:@"?client_id=%@",client_id]];
        path = [path stringByAppendingString:[NSString stringWithFormat:@"&redirect_uri=%@",redirect_uri]];
        path = [path stringByAppendingString:@"&response_type=code"];
        _requestAuthorizePath = path;
    }
    return _requestAuthorizePath;
}

- (NSString *)requestAccessTokenPathWithCode:(NSString *)code{
    NSString *client = [NSString stringWithFormat:@"?client_id=%@",client_id];
    NSString *app = [NSString stringWithFormat:@"&client_secret=%@",app_Secret];
    NSString *type = @"&grant_type=authorization_code";
    NSString *redirect = [NSString stringWithFormat:@"&redirect_uri=%@",redirect_uri];
    NSString *accCode = [NSString stringWithFormat:@"&code=%@",code];
    NSString *pathURL = [NSString stringWithFormat:@"%@%@%@%@%@%@",accessTokenURL,client,app,type,redirect,accCode];
    return pathURL;
}

@end
