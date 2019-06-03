//
//  JRListViewController.m
//  MVVM_RACDemo
//
//  Created by yangln on 2019/6/3.
//  Copyright © 2019 yangln. All rights reserved.
//

#import "JRListViewController.h"
#import "JRListViewModel.h"
#import "QRCTableViewManager.h"
#import "JRListTableViewCell.h"

@interface JRListViewController ()

@property (nonatomic, strong) JRListViewModel *listViewModel;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) QRCTableViewManager *tableViewManager;

@end

@implementation JRListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"List";
    
    [self initTableView];
    [self bindData];
}

- (void)initTableView {
    self.tableViewManager = [[QRCTableViewManager alloc] init];
    UITableView *tableView = [self.tableViewManager createTableViewWithFrame:CGRectMake(0, 0, JRScreenWidth, JRScreenHeight) stye: UITableViewStylePlain];
    [self.tableViewManager registTableCellClass:[JRListTableViewCell class] cellIdentifier:NSStringFromClass([JRListTableViewCell class])];
    [self.tableViewManager setDidSelect:^(UITableView * _Nonnull tableView, NSIndexPath * _Nonnull indexPath, id  _Nonnull model) {
        if ([model isKindOfClass:[JRListModel class]]) {
            JRListModel *listModel = (JRListModel *)model;
            NSLog(@"%@===%@", listModel.text, listModel.viewClass);
        }
    }];
    
    [self.view addSubview:tableView];
}

- (void)bindData {
    self.listViewModel = [[JRListViewModel alloc] init];
    
    @weakify(self);
    [self.listViewModel.racSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if ([x isKindOfClass:[NSArray class]]) {
            self.dataSource = x;
            [self.tableViewManager loadDataList:x hasNext:NO];
        }
        //加载数据
    }];
    
    [self.listViewModel loadData];
}

@end
