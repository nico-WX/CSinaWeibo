//
//  CSHomeViewController.m
//  CSinaWeibo
//
//  Created by 🐙怪兽 on 2019/2/23.
//  Copyright © 2019 com.😈. All rights reserved.
//

#import "CSHomeViewController.h"
#import "CSStatusCell.h"

#import "CSRequestPath.h"
#import "CSResponseRoot.h"
#import "CSHomeDataSource.h"

@interface CSHomeViewController ()<UICollectionViewDelegate,CSDataSourceDelegate>
@property(nonatomic,strong) UICollectionView *colletionView;
@property(nonatomic,strong) UICollectionViewFlowLayout *layout;
@property(nonatomic,strong) CSHomeDataSource *dataSource;
@end

static NSString *const identifier = @"status cell dientifier";
@implementation CSHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self.view setBackgroundColor:UIColor.cyanColor];
    [self.view addSubview:self.colletionView];
    _dataSource = [[CSHomeDataSource alloc] initWithCollectionView:_colletionView
                                                        identifier:identifier
                                                 sectionIdentifier:nil
                                                          delegate:self];
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self.colletionView setFrame:self.view.bounds];
}

- (void)configureCell:(CSStatusCell*)cell item:(CSStatus*)item{
    [cell configureCellWith:item];
}

- (UICollectionView *)colletionView{
    if (!_colletionView) {
        _layout = [UICollectionViewFlowLayout new];
        CGFloat w = CGRectGetWidth(self.view.bounds) - 16;
        CGFloat h = 200;
        [_layout setItemSize:CGSizeMake(w, h)];
        //[_layout setEstimatedItemSize:CGSizeMake(w, h)];

        _colletionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_layout];
        [_colletionView registerClass:[CSStatusCell class] forCellWithReuseIdentifier:identifier];
        [_colletionView setBackgroundColor:[UIColor colorWithWhite:1 alpha:0]];
        [_colletionView setDelegate:self];
    }
    return _colletionView;
}

@end
