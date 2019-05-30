//
//  JRBaseViewController.h
//  MVVM_RACDemo
//
//  Created by yangln on 2019/5/30.
//  Copyright © 2019 yangln. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JRBaseViewController : UIViewController

/**
 初始化
 @param title 标题
 */
- (id)initWithTitle:(NSString *)title;

/**
 创建按钮
 @param title 标题
 @param tag tag
 */
- (JRUIButton *)createButtonWithTitle:(NSString *)title tag:(NSInteger)tag;

@end

NS_ASSUME_NONNULL_END
