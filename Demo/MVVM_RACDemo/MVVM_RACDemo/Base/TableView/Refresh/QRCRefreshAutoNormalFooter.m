//
//  QRCRefreshAutoNormalFooter.m
//  QiyiDemo
//
//  Created by yanglunan on 2019/4/15.
//  Copyright © 2019 yanglunan. All rights reserved.
//

#import "QRCRefreshAutoNormalFooter.h"

@implementation QRCRefreshAutoNormalFooter

- (void)prepare {
    [super prepare];
    [self setTitle:@"普通闲置状态" forState:MJRefreshStateIdle];
    [self setTitle:@"松开就可以进行刷新的状态" forState:MJRefreshStatePulling];
    [self setTitle:@"正在刷新中的状态" forState:MJRefreshStateRefreshing];
    [self setTitle:@"即将刷新的状态" forState:MJRefreshStateWillRefresh];
    [self setTitle:@"所有数据加载完毕，没有更多的数据了" forState:MJRefreshStateNoMoreData];
}

@end
