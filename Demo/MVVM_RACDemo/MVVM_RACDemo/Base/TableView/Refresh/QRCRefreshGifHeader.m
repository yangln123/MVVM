//
//  QRCRefreshGifHeader.m
//  QiyiDemo
//
//  Created by yanglunan on 2019/4/11.
//  Copyright © 2019 yanglunan. All rights reserved.
//

#import "QRCRefreshGifHeader.h"

@interface QRCRefreshGifHeader ()

@property (nonatomic, assign) CGSize imageSize;

@end

@implementation QRCRefreshGifHeader

- (void)prepare {
    [super prepare];
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=60; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%zd", i]];
        [idleImages addObject:image];
    }
    [self setImages:idleImages forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
        [refreshingImages addObject:image];
    }
    [self setImages:refreshingImages forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
    
    
    [self setTitle:@"普通闲置状态" forState:MJRefreshStateIdle];
    [self setTitle:@"松开就可以进行刷新的状态" forState:MJRefreshStatePulling];
    [self setTitle:@"正在刷新中的状态" forState:MJRefreshStateRefreshing];
    [self setTitle:@"即将刷新的状态" forState:MJRefreshStateWillRefresh];
    
    //隐藏时间
    self.lastUpdatedTimeLabel.hidden = YES;
//    //隐藏状态
//    self.stateLabel.hidden = YES;
}

//重新布局子控件
- (void)placeSubviews {
    [super placeSubviews];
    
    self.stateLabel.textAlignment = NSTextAlignmentCenter;
    self.gifView.contentMode = UIViewContentModeCenter;
    self.lastUpdatedTimeLabel.hidden = YES;
    //stateLabel , gifView重新布局
    self.gifView.mj_origin = CGPointMake((self.bounds.size.width - self.imageSize.width)* 0.5, 5);
    self.gifView.mj_size = CGSizeMake(50, 50);
    self.stateLabel.mj_y = CGRectGetMaxY(self.gifView.frame)+2.f;
    self.stateLabel.mj_h = 30;
}

- (void)setImages:(NSArray *)images forState:(MJRefreshState)state {
    [self setImages:images duration:images.count * 0.1 forState:state];
}

- (void)setImages:(NSArray *)images duration:(NSTimeInterval)duration forState:(MJRefreshState)state {
    [super setImages:images duration:duration forState:state]; 
    
    //取出第一张照片,求高度
    UIImage *image = images.firstObject;
    self.imageSize = image.size;
    self.mj_h = image.size.height + 30;
}

@end
