//
//  CSStatusCell.m
//  CSinaWeibo
//
//  Created by 🐙怪兽 on 2019/2/23.
//  Copyright © 2019 com.😈. All rights reserved.
//

#import "CSStatusCell.h"
#import "CSStatus.h"


@implementation CSStatusCell


- (void)configureCellWith:(CSStatus *)status{
    self.statusNameLabel.text = status.user.name;
    self.statusSubtitleLabel.text = status.user.location;

    NSString *url = status.user.profile_image_url;
    self.TextContentLabel.text = status.text;


}
@end
