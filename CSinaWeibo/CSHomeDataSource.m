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

#pragma mark - instancen method
- (instancetype)initWithCollectionView:(UICollectionView *)collectionView identifier:(NSString *)identifier sectionIdentifier:(NSString *)sectionIdentifier delegate:(id<CSDataSourceDelegate>)delegate{
    if (self = [super initWithCollectionView:collectionView identifier:identifier sectionIdentifier:sectionIdentifier delegate:delegate]) {
        [self reloadDataSourceWithCompletion:^(BOOL success) {
        }];
    }
    return self;
}

//刷新
- (void)reloadDataSourceWithCompletion:(void(^)(BOOL success))completion{
    [self loadDataWithCompletion:^{
        if (completion) {
            completion(self.root.statuses.count > 0);
        }
        [self.collectionView reloadData];
    }];
}
//加载分页
- (void)loadNextPageDataWithCompletion:(void (^)(BOOL))completion{
    if (completion) {
        completion(0);
    }
}
-(id)objectAtIndexPath:(NSIndexPath *)indexPath{
    return [self.root.statuses objectAtIndex:indexPath.row];
}

#pragma mark - helpe

- (void)loadDataWithCompletion:(void(^)(void))completion{

    NSURLRequest *request = [CSRequestPath.new home_TimeLine];
    [self dataTaskWithRequest:request handler:^(NSDictionary * _Nonnull json, NSHTTPURLResponse * _Nonnull response) {

        NSString *path = [[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"JSON.text"];
        //json 写入文件 调试用
        [[NSFileManager defaultManager] createFileAtPath:path contents:json.mj_JSONData attributes:nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.root = [CSResponseRoot instanceWithDict:json];
            if (completion) {
                completion();
            }
        });
    }];
}


#pragma mark - view dataSource
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
