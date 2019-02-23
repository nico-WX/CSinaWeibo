//
//  CSDataSource.h
//  CSinaWeibo
//
//  Created by 🐙怪兽 on 2019/2/23.
//  Copyright © 2019 com.😈. All rights reserved.
//


#import <UIKit/UIKit.h>


@protocol CSDataSourceDelegate <NSObject>
@optional
- (void)configureCell:(id)cell item:(id)item atIndexPath:(NSIndexPath*)indexPath;
- (void)configureCell:(id)cell item:(id)item ;

@end


@interface CSDataSource : NSObject<UITableViewDataSource,UICollectionViewDataSource>

@property(nonatomic,weak,readonly) UITableView *tableView;
@property(nonatomic,weak,readonly) UICollectionView *collectionView;
@property(nonatomic,weak,readonly) id<CSDataSourceDelegate> delegate;
@property(nonatomic,copy,readonly) NSString *identifier;
@property(nonatomic,copy,readonly) NSString *sectionIdentifier;


/**刷新数据源数据*/
- (void)reloadDataSource;
/**清除数据*/
- (void)clearDataSource;
/**子类辅助配置代理方法,子类内部配置数据时调用*/
- (void)configureCell:(id)cell item:(id)item atIndexPath:(NSIndexPath*)indexPath;

- (instancetype)initWithTableView:(UITableView*)tableViwe
                       identifier:(NSString*)identifier
                sectionIdentifier:(NSString*)sectionIdentifier
                         delegate:(id<CSDataSourceDelegate>)delegate;

- (instancetype)initWithCollectionView:(UICollectionView*)collectionView
                            identifier:(NSString*)identifier
                     sectionIdentifier:(NSString*)sectionIdentifier
                              delegate:(id<CSDataSourceDelegate>)delegate;

@end


