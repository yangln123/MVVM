//
//  QRCTableViewManager.m
//  QiyiDemo
//
//  Created by yanglunan on 2019/4/11.
//  Copyright © 2019 yanglunan. All rights reserved.
//

#import "QRCTableViewManager.h"
#import "MJRefresh.h"
#import "QRCRefreshNormalHeader.h"
#import "QRCRefreshAutoNormalFooter.h"
#import "QRCRefreshGifHeader.h"

@interface QRCTableViewManager () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
//@property (nonatomic, strong) NSString *cellIdentifier;
@property (nonatomic, strong) NSString *headerSectionIdentifier;
@property (nonatomic, strong) NSString *footerSectionIdentifier;
@property (nonatomic, assign) NSUInteger curCount;

@property (nonatomic, strong) NSRecursiveLock *lock;

@end

@implementation QRCTableViewManager

#pragma mark int
- (UITableView *)createTableViewWithFrame:(CGRect)frame stye:(UITableViewStyle)style {
    self.tableView = [[UITableView alloc] initWithFrame:frame style:style];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    if (self.headerView) {
        self.tableView.tableHeaderView = self.headerView();
    }
    if (self.footerView) {
        self.tableView.tableFooterView = self.footerView();
    }
    
    [self initData];
    
    return self.tableView;
}

- (void)registTableCellClass:(Class)cellClass cellIdentifier:(NSString *)cellIdentifier {
    if (cellClass) {
        [self.tableView registerClass:cellClass forCellReuseIdentifier:cellIdentifier];
    }
}

- (void)initData {
    self.allCellData = [NSMutableArray arrayWithCapacity:0];
    self.sections = [NSMutableArray arrayWithCapacity:0];
    self.curCount = 1;
    self.lock = [[NSRecursiveLock alloc] init];
}

- (void)registerHeaderClass:(Class)headerClass {
    self.headerSectionIdentifier = NSStringFromClass(headerClass);
    [self.tableView registerClass:headerClass forHeaderFooterViewReuseIdentifier:self.headerSectionIdentifier];
}

- (void)registerFooterClass:(Class)footerClass {
    self.footerSectionIdentifier = NSStringFromClass(footerClass);
    [self.tableView registerClass:footerClass forHeaderFooterViewReuseIdentifier:self.footerSectionIdentifier];
}

- (void)registerHeaderFooterClass:(Class)headerFooterClass {
    [self registerHeaderClass:headerFooterClass];
    [self registerFooterClass:headerFooterClass];
}

#pragma mark loadData
- (void)loadDataList:(NSArray *)list hasNext:(BOOL)hasNext {
    [self updateTableFromData:self.allCellData addData:list hasNext:hasNext];
}

- (void)loadSectionDataList:(NSArray<QRCTableBaseSectionModel *> *)list hasNext:(BOOL)hasNext {
    [self updateTableFromData:self.sections addData:list hasNext:hasNext];
}

- (void)updateTableFromData:(NSMutableArray *)fromData addData:(NSArray *)addData hasNext:(BOOL)hasNext{
    if (self.state == TableRefreshNormalState) {
        [self configTableView];
        self.curCount = 1;
        
        [self.lock lock];
        [fromData removeAllObjects];
        [fromData addObjectsFromArray:addData];
        [self.lock unlock];
        
        self.tableView.mj_footer.hidden = (addData.count == 0);
        [self.tableView reloadData];
    }
    else if (self.state == TableRefreshPullUpState) {
        [self.lock lock];
        [fromData addObjectsFromArray:addData];
        [self.lock unlock];
        
        if (hasNext) {
            [self.tableView.mj_footer endRefreshing];
        }
        else {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        [self.tableView reloadData];
    }
    else if (self.state == TableRefreshPullDownState) {
        [self.lock lock];
        [fromData removeAllObjects];
        [fromData addObjectsFromArray:addData];
        [self.lock unlock];
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
    }
}

- (void)configTableView {
//    __weak typeof (self) weakSelf = self;
//    if (self.refreshHeader) {
//        self.tableView.mj_header = [QRCRefreshGifHeader headerWithRefreshingBlock:^{
//            weakSelf.state = TableRefreshPullDownState;
//            weakSelf.curCount = 1;
//            weakSelf.refreshHeader(weakSelf.curCount);
//        }];
//    }
//
//    if (self.refreshFooter) {
//        MJRefreshAutoFooter *footer = [QRCRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//            weakSelf.state = TableRefreshPullUpState;
//            weakSelf.curCount ++;
//            weakSelf.refreshFooter(weakSelf.curCount);
//        }];
//        self.tableView.mj_footer = footer;
//        if (self.autoRefreshPercent < 0) {
//            footer.triggerAutomaticallyRefreshPercent = self.autoRefreshPercent;
//        }
//    }
}

#pragma mark delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections.count == 0 ? 1 : self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.sections.count == 0 ? self.allCellData.count : self.sections[section].cellModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id model = nil;
    NSString *identifier = nil;
    if (self.sections.count == 0) {
        model = self.allCellData[indexPath.row];
        QRCTableBaseCellModel *cellModel = (QRCTableBaseCellModel *)model;
        identifier = NSStringFromClass(cellModel.viewClass);
    }
    else {
        model = self.sections[indexPath.section].cellModels[indexPath.row];
        QRCTableBaseSectionModel *sectionModel = (QRCTableBaseSectionModel *)model;
        identifier = NSStringFromClass(sectionModel.viewClass);
    }
    
    QRCBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    [cell setCellModel:model];
    tableView.mj_footer.hidden = !(self.tableView.mj_footer.frame.origin.y > self.tableView.frame.size.height);
    cell.configCell = self.configCell;
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (self.sections.count == 0) {
        return nil;
    }
    else {
        QRCTableBaseHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:self.headerSectionIdentifier];
        QRCTableBaseSectionModel *model = self.sections[section];
        if (model.headerModel) {
            if (!view) {
                view = [NSClassFromString(self.headerSectionIdentifier) new];
            }
            [view setHeadFooterModel:model.headerModel];
            return view;
        }
        else {
            return nil;
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (self.sections.count == 0) {
        return nil;
    }
    else {
        QRCTableBaseHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:self.footerSectionIdentifier];
        QRCTableBaseSectionModel *model = self.sections[section];
        if (model.footerModel) {
            if (!view) {
                view = [NSClassFromString(self.footerSectionIdentifier) new];
            }
            [view setHeadFooterModel:model.footerModel];
            return view;
        }
        else {
            return nil;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    id model = nil;
    NSString *identifier = nil;
    if (self.sections.count == 0) {
        model = self.allCellData[indexPath.row];
        QRCTableBaseCellModel *cellModel = (QRCTableBaseCellModel *)model;
        identifier = NSStringFromClass(cellModel.viewClass);
    }
    else {
        model = self.sections[indexPath.section].cellModels[indexPath.row];
        QRCTableBaseSectionModel *sectionModel = (QRCTableBaseSectionModel *)model;
        identifier = NSStringFromClass(sectionModel.viewClass);
    }
    QRCBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    return cell.getHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.sections.count == 0) {
        return 0.001;
    }
    else {
        QRCTableBaseSectionModel *model = self.sections[section];
        QRCTableBaseHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:self.headerSectionIdentifier];
        if (!view) {
            view = [NSClassFromString(self.headerSectionIdentifier) new];
        }
        return model.headerModel == nil ? 0.001 : [view getHeight];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (self.sections.count == 0) {
        return 0.001;
    }
    else {
        QRCTableBaseSectionModel *model = self.sections[section];
        QRCTableBaseHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:self.footerSectionIdentifier];
        if (!view) {
            view = [NSClassFromString(self.footerSectionIdentifier) new];
        }
        return model.footerModel == nil ? 0.001 : [view getHeight];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (self.sections.count == 0) {
        if (indexPath.section > self.allCellData.count) {
            return;
        }
    }
    else {
        if (indexPath.section > self.sections.count) {
            return;
        }
    }
    
    if (self.didSelect) {
        self.didSelect(tableView, indexPath, [self getSelectModel:indexPath]);
    }
}

- (id)getSelectModel:(NSIndexPath *)indexPath {
    id model = nil;
    if (self.sections.count == 0) {
        model = self.allCellData[indexPath.row];
    }
    else {
        model = self.sections[indexPath.section].cellModels[indexPath.row];
    }
    
    return model;
}


@end
