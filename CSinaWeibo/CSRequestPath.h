//
//  CSRequestPath.h
//  CSinaWeibo
//
//  Created by 🐙怪兽 on 2019/2/23.
//  Copyright © 2019 com.😈. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CSRequestPath : NSObject
//最新微博
- (NSURLRequest*)home_TimeLine;
- (NSURLRequest*)user_TimeLine;
- (NSURLRequest*)repost_timeline;
- (NSURLRequest*)mentions;

/**将短链接转换为长链接*/
- (NSURLRequest*)short_url_expandWithShortURL:(NSString*)shortURL;

@end

NS_ASSUME_NONNULL_END
