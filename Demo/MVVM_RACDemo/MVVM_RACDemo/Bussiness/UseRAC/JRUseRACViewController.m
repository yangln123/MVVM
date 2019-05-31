//
//  JRUseRACViewController.m
//  MVVM_RACDemo
//
//  Created by yangln on 2019/5/30.
//  Copyright © 2019 yangln. All rights reserved.
//

#import "JRUseRACViewController.h"
#import "JRUIKitViewController.h"
#import "JRKVOViewController.h"
#import "JRFoundationViewController.h"
#import "JRKVOViewController.h"
#import "JREventSignalViewController.h"
#import "JRNetViewController.h"

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
}

- (void)addButtons {
    NSArray *titleArray = @[@"基本使用", @"UIkit", @"Foundation", @"KVO", @"Event Signal", @"Net"];
    for (int i = 0; i < [titleArray count]; i ++) {
        JRUIButton *button = [self createButtonWithTitle:titleArray[i] tag:i];
        [self.view  addSubview:button];
    }
}

- (void)handleAction:(UIButton *)button {
    NSInteger tag = button.tag;
    if (tag == 0) {
        [self racNormalUse];
    }
    else if (tag == 1) {
        [self racUIKitUse];
    }
    else if (tag == 2) {
        [self racFoundationUse];
    }
    else if (tag == 3) {
        [self racKVOUse];
    }
    else if (tag == 4) {
        [self racSignalUse];
    }
    else if (tag == 5) {
        [self racNetUse];
    }
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
    
    RACDisposable *disposable = [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@1", x);
    }];
    [disposable dispose];
    
    RACSubject *subject = [RACSubject subject];
    [subject sendNext:@"发送信号1"];
    [subject subscribeNext:^(id  _Nullable x) {
        NSLog(@"Subject %@", x);
    }];
    [subject sendNext:@"发送信号2"];

    RACReplaySubject *replaySubject = [RACReplaySubject subject];
    [replaySubject sendNext:@"发送信号1"];
    [replaySubject subscribeNext:^(id  _Nullable x) {
        NSLog(@"ReplaySubject %@", x);
    }];
    [replaySubject sendNext:@"发送信号2"];
}

#pragma mark UIKit
- (void)racUIKitUse {
    JRUIKitViewController *vc = [[JRUIKitViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark UIFoundation
- (void)racFoundationUse {
    JRFoundationViewController *vc = [[JRFoundationViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark KVO
- (void)racKVOUse {
    JRKVOViewController *vc = [[JRKVOViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark Signal
- (void)racSignalUse {
    JREventSignalViewController *vc = [[JREventSignalViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark Net
- (void)racNetUse {
    JRNetViewController *vc = [[JRNetViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
