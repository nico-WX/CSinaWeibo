//
//  CSDataSource.m
//  CSinaWeibo
//
//  Created by 🐙怪兽 on 2019/2/23.
//  Copyright © 2019 com.😈. All rights reserved.
//

#import "CSDataSource.h"

@implementation CSDataSource

#pragma mark - init
- (instancetype)initWithTableView:(UITableView *)tableViwe identifier:(NSString *)identifier sectionIdentifier:(NSString *)sectionIdentifier delegate:(id<CSDataSourceDelegate>)delegate{
    if (self = [super init]) {
        _tableView = tableViwe;
        [_tableView setDataSource:self];

        _identifier = identifier;
        _sectionIdentifier = sectionIdentifier;
        _delegate = delegate;
    }
    return self;
}
- (instancetype)initWithCollectionView:(UICollectionView *)collectionView identifier:(NSString *)identifier sectionIdentifier:(NSString *)sectionIdentifier delegate:(id<CSDataSourceDelegate>)delegate{
    if (self = [super init]) {
        _collectionView = collectionView;
        [_collectionView setDataSource:self];

        _identifier = identifier;
        _sectionIdentifier = sectionIdentifier;
        _delegate = delegate;
    }
    return self;
}

#pragma mark - instance method
- (void)reloadDataSourceWithCompletion:(void(^)(BOOL success))completion{
}

-(void)loadNextPageDataWithCompletion:(void (^)(BOOL success))completion{
}

-(void)clearDataSource{
}
- (id)objectAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

// 默认实现设置成 0
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:_identifier forIndexPath:indexPath];
    [self configureCell:cell item:@"0" atIndexPath:indexPath];
    return cell;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 0;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:_identifier forIndexPath:indexPath];
    [self configureCell:cell item:@"0" atIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(id)cell item:(id)item atIndexPath:(NSIndexPath *)indexPath{
    if ([_delegate respondsToSelector:@selector(configureCell:item:)]) {
        [_delegate configureCell:cell item:item];
    }
    if ([_delegate respondsToSelector:@selector(configureCell:item:atIndexPath:)]) {
        [_delegate configureCell:cell item:item atIndexPath:indexPath];
    }
}

@end
