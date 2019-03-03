//
//  CSBaseViewController.m
//  CSinaWeibo
//
//  Created by 🐙怪兽 on 2019/2/23.
//  Copyright © 2019 com.😈. All rights reserved.
//

#import "CSBaseViewController.h"
#import "CSAuthorizePath.h"
#import <WebKit/WebKit.h>

@interface CSBaseViewController ()<WKNavigationDelegate>
@property(nonatomic,strong) WKWebView *webView;
@end


static NSString *const loginUserKey = @"logined user defaults Key";
@implementation CSBaseViewController

@synthesize currentUser = _currentUser;

- (void)viewDidLoad {
    [super viewDidLoad];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginNewUser) name:TokenForbiddenNotification object:nil];
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self.webView setFrame:self.view.bounds];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

    NSLog(@"currem =%@",self.currentUser);
}

- (void)loginNewUser{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:CSAuthorizePath.new.requestAuthorizePath]];
    [self.webView loadRequest:request];

    //显示webView
    [UIView animateWithDuration:.35 animations:^{

        NSLog(@"selfview %@",self.view.subviews);

        NSLog(@"self =%@",self.view);

        [self.view insertSubview:self.webView atIndex:100];
    }];
}


- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{

    //截取回调中的code  用code 请求accessToken
    NSString *path = webView.URL.absoluteString;
    NSRange range = [path rangeOfString:@"code="];

    NSUInteger loc =  range.length+range.location;
    NSUInteger len = path.length - loc;
    NSRange codeRange = NSMakeRange(loc, len);
    NSString *code = [path substringWithRange:codeRange];

    if (code.length > 0) {
        NSString *accessURL = [CSAuthorizePath.new requestAccessTokenPathWithCode:code];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:accessURL]];
        [request setHTTPMethod:@"POST"];
        //交换Token
        [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            if (error == nil) {
                CSLoginUser *user = [CSLoginUser instanceWithDict:json];
                self->_currentUser = user;

                NSDictionary *dict = user.dictionaryValue;


                //NSData *userData = [NSKeyedArchiver archivedDataWithRootObject:user requiringSecureCoding:YES error:nil];
                [[NSUserDefaults standardUserDefaults] setObject:dict forKey:loginUserKey];
                [[NSUserDefaults standardUserDefaults] synchronize];

            }else{
                NSLog(@"error :%@",error.localizedDescription);
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.webView removeFromSuperview];
            });
        }] resume];
    }
}


#pragma mark getter;
- (WKWebView *)webView{
    if (!_webView) {
        _webView = [[WKWebView alloc] init];
        [_webView setNavigationDelegate:self];
    }
    return _webView;
}

- (CSLoginUser *)currentUser{
    if (!_currentUser) {
        NSDictionary *json = [[NSUserDefaults standardUserDefaults] valueForKey:loginUserKey];
        _currentUser = [CSLoginUser instanceWithDict:json];
        if (_currentUser.access_token.length == 0) {
            [self loginNewUser];
        }
    }
    return _currentUser;
}

@end
