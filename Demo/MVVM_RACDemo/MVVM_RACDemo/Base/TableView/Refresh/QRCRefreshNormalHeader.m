//
//  QRCRefreshNormalHeader.m
//  QiyiDemo
//
//  Created by yanglunan on 2019/4/11.
//  Copyright © 2019 yanglunan. All rights reserved.
//

#import "QRCRefreshNormalHeader.h"

@implementation QRCRefreshNormalHeader

- (void)prepare {
    [super prepare];
    
    //所有的自定义东西都放在这里
    [self setTitle:@"普通闲置状态" forState:MJRefreshStateIdle];
    [self setTitle:@"松开就可以进行刷新的状态" forState:MJRefreshStatePulling];
    [self setTitle:@"正在刷新中的状态" forState:MJRefreshStateRefreshing];
    [self setTitle:@"即将刷新的状态" forState:MJRefreshStateWillRefresh];
    [self setTitle:@"所有数据加载完毕，没有更多的数据了" forState:MJRefreshStateNoMoreData];
    //一些其他属性设置
    /*
     // 设置字体
     self.stateLabel.font = [UIFont systemFontOfSize:15];
     self.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:14];
     
     // 设置颜色
     self.stateLabel.textColor = [UIColor redColor];
     self.lastUpdatedTimeLabel.textColor = [UIColor blueColor];
     // 隐藏时间
     self.lastUpdatedTimeLabel.hidden = YES;
     // 隐藏状态
     self.stateLabel.hidden = YES;
     // 设置自动切换透明度(在导航栏下面自动隐藏)
     self.automaticallyChangeAlpha = YES;
     */
}

//重新布局子控件
- (void)placeSubviews {
    [super placeSubviews];
   
    //
//    self.arrowView
}

@end
