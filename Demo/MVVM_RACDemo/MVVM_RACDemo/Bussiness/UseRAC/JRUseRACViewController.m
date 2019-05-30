//
//  JRUseRACViewController.m
//  MVVM_RACDemo
//
//  Created by yangln on 2019/5/30.
//  Copyright © 2019 yangln. All rights reserved.
//

#import "JRUseRACViewController.h"

typedef NS_ENUM(NSInteger, JRSelectorType) {
    JRSelectorNormalType = 0,
    JRSelectorUIKitType,
    JRSelectorFoundationType,
    JRSelectorKVOType,
    JRSelectorEventSignalType,
    JRSelectorNetType
};

@interface JRUseRACViewController ()


@end

@implementation JRUseRACViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"RAC使用";
    [self addButtons];
    [self racNormalUse];
}

- (void)addButtons {
    NSArray *titleArray = @[@"基本使用", @"UIkit", @"Foundation", @"KVO", @"Signal", @"Net"];
    for (int i = 0; i < [titleArray count]; i ++) {
        JRUIButton *button = [self createButtonWithTitle:titleArray[i] tag:i];
        [self.view  addSubview:button];
    }
}

- (void)hanleAction:(UIButton *)button {
    NSInteger tag = button.tag;
    if (tag == 0) {
        
    }
    else if (tag == 1) {
        
    }
}

- (void)racUses {
    [self racNormalUse];
    [self racUIKitUse];
    [self racFoundationUse];
    [self racKVOUse];
    [self racSignalUse];
    [self racNetUse];
}

#pragma mark Normal
- (void)racNormalUse {
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@"发送信号"];
        [subscriber sendNext:@{@"key" : @"value"}];
        [subscriber sendCompleted];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"信号销毁");
        }];
    }];
    
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
    
    RACMulticastConnection *connection = [signal publish];
    [connection.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"1接收到数据%@", x);
    }];

    
}

#pragma mark UIKit
- (void)racUIKitUse {
    
}

#pragma mark UIFoundation
- (void)racFoundationUse {
    
}

#pragma mark KVO
- (void)racKVOUse {
    
}

#pragma mark Signal
- (void)racSignalUse {
    
}

#pragma mark Net
- (void)racNetUse {
    
}

@end
