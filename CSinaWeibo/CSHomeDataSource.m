//
//  CSHomeDataSource.m
//  CSinaWeibo
//
//  Created by 🐙怪兽 on 2019/2/23.
//  Copyright © 2019 com.😈. All rights reserved.
//

#import "CSHomeDataSource.h"
#import "CSRequestPath.h"
#import "CSResponseRoot.h"

@interface CSHomeDataSource ()
@property(nonatomic,strong) CSResponseRoot *root;
@end
@implementation CSHomeDataSource

- (instancetype)initWithCollectionView:(UICollectionView *)collectionView identifier:(NSString *)identifier sectionIdentifier:(NSString *)sectionIdentifier delegate:(id<CSDataSourceDelegate>)delegate{
    if (self = [super initWithCollectionView:collectionView identifier:identifier sectionIdentifier:sectionIdentifier delegate:delegate]) {
        [self reloadDataSource];
    }
    return self;
}

- (void)reloadDataSource{
    [self loaddataWithCompletion:^{
        [self.collectionView reloadData];
    }];
}
- (void)loaddataWithCompletion:(void(^)(void))completion{
    NSURLRequest *request = [CSRequestPath.new home_TimeLine];
    [self dataTaskWithRequest:request handler:^(NSDictionary * _Nonnull json, NSHTTPURLResponse * _Nonnull response) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.root = [CSResponseRoot instanceWithDict:json];
            if (completion) {
                completion();
            }
        });
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.root.statuses.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.identifier forIndexPath:indexPath];
    CSStatus *status = [self.root.statuses objectAtIndex:indexPath.row];
    [self configureCell:cell item:status atIndexPath:indexPath];
    return cell;
}
@end
