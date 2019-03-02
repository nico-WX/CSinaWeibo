//
//  CSHomeViewController.m
//  CSinaWeibo
//
//  Created by 🐙怪兽 on 2019/2/23.
//  Copyright © 2019 com.😈. All rights reserved.
//

#import <MJRefresh.h>
#import <Masonry.h>

#import "CSHomeViewController.h"
#import "CSStatusCell.h"
#import "CSNewStatusCell.h"

#import "CSRequestPath.h"
#import "CSResponseRoot.h"
#import "CSHomeDataSource.h"

@interface CSHomeViewController ()<UICollectionViewDelegate,CSDataSourceDelegate>
@property(nonatomic,strong) UICollectionView *colletionView;
@property(nonatomic,strong) UICollectionViewFlowLayout *layout;
@property(nonatomic,assign) UIEdgeInsets insets;

@property(nonatomic,strong) CSHomeDataSource *dataSource;
@end


static NSString *const identifier = @"status cell dientifier";

@implementation CSHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _insets = UIEdgeInsetsMake(0, 8, 0, 8);

    [self.view setBackgroundColor:[UIColor colorWithWhite:0.95 alpha:1]];
    [self.view addSubview:self.colletionView];

    //数据
    _dataSource = [[CSHomeDataSource alloc] initWithCollectionView:_colletionView
                                                        identifier:identifier
                                                 sectionIdentifier:nil
                                                          delegate:self];

    //刷新数据
    __weak typeof(self) weakSelf = self;
    [self.colletionView setMj_header:[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf.dataSource reloadDataSourceWithCompletion:^(BOOL success) {

            MJRefreshNormalHeader *header = (MJRefreshNormalHeader*)weakSelf.colletionView.mj_header;
            if (success) {
                [header endRefreshing];
            }else{
                [header setTitle:@"刷新失败" forState:MJRefreshStateRefreshing];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.35 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [header endRefreshing];
                });
            }

        }];
    }]];
    //加载分页
    [self.colletionView setMj_footer:[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf.dataSource loadNextPageDataWithCompletion:^(BOOL success) {

            MJRefreshFooter *footer = weakSelf.colletionView.mj_footer;
            success ? [footer endRefreshing] : [footer endRefreshingWithNoMoreData];
        }];
    }]];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];


    //一开始显示时, 触发一次刷新, 刷新cell 布局,计算高度
    [self.dataSource reloadDataSourceWithCompletion:^(BOOL success) {
        [self.colletionView.mj_header endRefreshing];
    }];
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];

    UIView *superView = self.view;
    [_colletionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(superView);
    }];
    //[self.colletionView setFrame:self.view.bounds];
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //CSStatus *status = [self.dataSource objectAtIndexPath:indexPath];

    NSString *path = @"http://t.cn/EVkg9h2" ;
    //https://api.weibo.com/2/short_url/expand.json?access_token=2.00AZDAcH6NFl6B1af85e1942wkBjSC&url_short=http://t.cn/EVkg9h2

    NSURLRequest *request = [[CSRequestPath new] short_url_expandWithShortURL:path];
    [self dataTaskWithRequest:request handler:^(NSDictionary * _Nonnull json, NSHTTPURLResponse * _Nonnull response) {
        NSLog(@"res =%@",response);
        NSLog(@"json =%@",json);

    }];

}

- (void)configureCell:(CSNewStatusCell*)cell item:(CSStatus*)item{
    [cell configureCellWith:item];
}

- (UICollectionView *)colletionView{
    if (!_colletionView) {
        _layout = [UICollectionViewFlowLayout new];
        CGFloat w = CGRectGetWidth(self.view.bounds)-(_insets.left+_insets.right);
        [_layout setEstimatedItemSize:CGSizeMake(w, 200)];

        _colletionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_layout];
        [_colletionView registerClass:[CSNewStatusCell class] forCellWithReuseIdentifier:identifier];
        [_colletionView setBackgroundColor:[UIColor colorWithWhite:1 alpha:0]];
        [_colletionView setDelegate:self];
    }
    return _colletionView;
}


@end
