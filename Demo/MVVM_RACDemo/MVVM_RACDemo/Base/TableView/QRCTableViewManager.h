//
//  QRCTableViewManager.h
//  QiyiDemo
//
//  Created by yanglunan on 2019/4/11.
//  Copyright © 2019 yanglunan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "QRCBaseTableViewCell.h"
#import "QRCTableBaseSectionModel.h"
#import "QRCTableBaseHeaderFooterView.h"
#import "QRCTableBaseCellModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, TableRefreshState) {
    TableRefreshNormalState = 0, //正常
    TableRefreshPullDownState, //下拉
    TableRefreshPullUpState //上拉
};

typedef UIView *(^viewBlock)(void);//创建headerView、footerView
typedef void (^refreshBlock)(NSInteger curPage);//刷新
typedef void (^selectBlock)(UITableView *tableView, NSIndexPath *indexPath, id model);//点击选择


@interface QRCTableViewManager : NSObject

@property (nonatomic, assign) BOOL shouldShowHeader;//是否显示下拉刷新
@property (nonatomic, copy) refreshBlock refreshHeader;//下拉刷新
@property (nonatomic, assign) BOOL shouldShowFooter;//是否显示上拉刷新
@property (nonatomic, copy) refreshBlock refreshFooter;//上拉刷新
@property (nonatomic, copy) selectBlock didSelect;//点击
@property (nonatomic, assign) TableRefreshState state;//刷新状态
@property (nonatomic, copy) cellBlock configCell;//设置cell
@property (nonatomic, copy) viewBlock headerView;//header
@property (nonatomic, copy) viewBlock footerView;//footer

@property (nonatomic, assign) CGFloat autoRefreshPercent;//设置预加载(为负值)

@property (nonatomic, strong) NSMutableArray *allCellData;//所有cell数据
@property (nonatomic, strong) NSMutableArray <QRCTableBaseSectionModel *> *sections;//section数据

/**
  创建Tableview
 @param frame frame
 @param style 样式
 */
- (UITableView *)createTableViewWithFrame:(CGRect)frame stye:(UITableViewStyle)style;

/**
 注册cell
 @param cellClass cell
 @param cellIdentifier 标识
 */
- (void)registTableCellClass:(Class)cellClass cellIdentifier:(NSString *)cellIdentifier;

/**
 注册header
 */
- (void)registerHeaderClass:(Class)headerClass;

/**
 注册fooetr
 */
- (void)registerFooterClass:(Class)footerClass;

/**
 同时注册header和footer
 */
- (void)registerHeaderFooterClass:(Class)headerFooterClass;

/**
 加载数据
 @param list 列表数据
 @param hasNext 是否有下一页
 */
- (void)loadDataList:(NSArray *)list hasNext:(BOOL)hasNext;

/**
 加载数据
 @param list section列表数据
 @param hasNext 是否有下一页
 */
- (void)loadSectionDataList:(NSArray<QRCTableBaseSectionModel *> *)list hasNext:(BOOL)hasNext;

@end

NS_ASSUME_NONNULL_END
