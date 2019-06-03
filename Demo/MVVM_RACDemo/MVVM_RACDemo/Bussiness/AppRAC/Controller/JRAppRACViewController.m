//
//  JRAppRACViewController.m
//  MVVM_RACDemo
//
//  Created by yangln on 2019/5/30.
//  Copyright © 2019 yangln. All rights reserved.
//

#import "JRAppRACViewController.h"
#import "JRListViewModel.h"

@interface JRAppRACViewController ()

@property (nonatomic, strong) JRListViewModel *listViewModel;
@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation JRAppRACViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"RAC应用";
    [self bindData];
}

- (void)bindData {
    self.listViewModel = [[JRListViewModel alloc] init];
    
    @weakify(self);
    [self.listViewModel.racSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if ([x isKindOfClass:[NSArray class]]) {
            self.dataSource = x;
        }
        //加载数据
    }];
    
    [self.listViewModel loadData];
}



@end
