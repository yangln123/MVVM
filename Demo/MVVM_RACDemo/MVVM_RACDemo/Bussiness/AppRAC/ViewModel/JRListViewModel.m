//
//  JRListViewModel.m
//  MVVM_RACDemo
//
//  Created by yangln on 2019/6/3.
//  Copyright © 2019 yangln. All rights reserved.
//

#import "JRListViewModel.h"

@implementation JRListViewModel

- (id)init {
    self = [super init];
    if (self) {
        self.racCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                [subscriber sendNext:@"发送"];
                return nil;
            }];
        }];
        self.racSubject = [RACSubject subject];
        self.dataArray = [NSMutableArray arrayWithCapacity:0];
    }
    return self;
}

- (void)loadData {
    for (int i = 0; i < 10; i ++) {
        JRListModel *model = [[JRListModel alloc] init];
        model.title = [NSString stringWithFormat:@"Title--%d", i];
        model.code = [NSString stringWithFormat:@"Code--%d", i];
        [self.dataArray addObject:model];
    }
    
    [self.racSubject sendNext:self.dataArray];
}

@end
