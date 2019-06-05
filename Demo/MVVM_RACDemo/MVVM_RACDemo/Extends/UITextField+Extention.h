//
//  UITextField+Extention.h
//  MVVM_RACDemo
//
//  Created by yangln on 2019/6/5.
//  Copyright © 2019 yangln. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^ActionBlock)(void);

@interface UITextField (Extention)

@property (nonatomic, assign) NSInteger maxLength;//最大输入长度
@property (nonatomic, copy) ActionBlock maxAction;//超过最大回调

@end

NS_ASSUME_NONNULL_END
