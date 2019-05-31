//
//  JRUIKitViewController.m
//  MVVM_RACDemo
//
//  Created by yangln on 2019/5/31.
//  Copyright © 2019 yangln. All rights reserved.
//

#import "JRUIKitViewController.h"

@interface JRUIKitViewController ()

@end

@implementation JRUIKitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addButton];
    [self addGesture];
}

- (void)addButton {
    JRUIButton *button = [JRUIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100.0, 100, 160.0, 60.0);
    button.backgroundColor = [UIColor lightGrayColor];
    [button setTitle:@"Click" forState:UIControlStateNormal];
    [self.view addSubview:button];
    
//    RACSignal *signal = [button rac_signalForControlEvents:UIControlEventTouchUpInside];
//    [signal subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@", x);
//    }];
    
    [button addTarget:self action:@selector(handleAction:) forControlEvents:UIControlEventTouchUpInside];
    RACSignal *signal = [self rac_signalForSelector:@selector(handleAction:)];
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
}

- (void)handleAction:(UIButton *)button {
    NSLog(@"click");
}

- (void)addGesture {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [[tap rac_gestureSignal] subscribeNext:^(id x) {
        NSLog(@"tap");
    }];
    [self.view addGestureRecognizer:tap];
}

@end
