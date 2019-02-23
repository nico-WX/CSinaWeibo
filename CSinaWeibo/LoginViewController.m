//
//  AuthorizeViewController.m
//  CSinaWeibo
//
//  Created by 🐙怪兽 on 2019/2/22.
//  Copyright © 2019 com.😈. All rights reserved.
//

#import "LoginViewController.h"
#import <WebKit/WebKit.h>
#import "CSLoginUser.h"
#import "CSAuthorizePath.h"
#import "CSLoginUserManager.h"

@interface LoginViewController ()<WKUIDelegate,WKNavigationDelegate>
@property(nonatomic,strong) WKWebView *webView;
@property(nonatomic,strong) CSLoginUser *user;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.webView];
    [self.view setBackgroundColor:UIColor.whiteColor];

    // 
    [self loginNewUser];
}
- (void)loginNewUser{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:CSAuthorizePath.new.requestAuthorizePath]];
    [self.webView loadRequest:request];
}


- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{

    //截取回调中的code 交换Token
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
                self.user = [CSLoginUser instanceWithDict:json];
                [[CSLoginUserManager shareUserManager] setCurrentUser:self.user];
                //[[CSLoginUserManager shareUserManager] addLoginUser:self.user];
            }else{
                NSLog(@"error :%@",error.localizedDescription);
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self dismissViewControllerAnimated:YES completion:nil];
            });
        }] resume];
    }

}


- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self.webView setFrame:self.view.bounds];
}

- (WKWebView *)webView{
    if (!_webView) {
        _webView = [[WKWebView alloc] init];
        [_webView setNavigationDelegate:self];
    }
    return _webView;
}

@end
