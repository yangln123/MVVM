//
//  JRFoundationViewController.m
//  MVVM_RACDemo
//
//  Created by yangln on 2019/5/31.
//  Copyright © 2019 yangln. All rights reserved.
//

#import "JRFoundationViewController.h"

@interface JRFoundationViewController ()

@end

@implementation JRFoundationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self handleTravesal];
    
    [self handleTimer];
    
    [self handleDelay];
    
    [self handleDelegate];
}

- (void)handleTravesal {
    NSArray *array = @[@"1", @"2", @"3", @"4", @"5"];
    [array.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"数组内容：%@", x);
    }];
    
    NSDictionary *dictionary = @{@"key1":@"value1", @"key2":@"value2", @"key3":@"value3"};
    [dictionary.rac_sequence.signal subscribeNext:^(RACTuple * _Nullable x) {
        //拆分元组
        RACTupleUnpack(NSString *key, NSString *value) = x;
        NSLog(@"字典内容：%@ : %@", key, value);
    }];
}

- (void)handleTimer {
    RACSignal *timeSignal = [RACSignal interval:1.0 onScheduler:[RACScheduler mainThreadScheduler]];

//    [timeSignal.repeat subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@", x);
//    }];
    
    timeSignal = [timeSignal take:3.0];
    [timeSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    } completed:^{
        NSLog(@"timer end");
    }];
}

- (void)handleDelay {
    RACSignal *delaySignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@"发送信号"];
        return nil;
    }];
    [[delaySignal delay:2.0] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
}

- (void)handleDelegate {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"RAC" message:@"RAC TEST" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"other", nil];
    [[self rac_signalForSelector:@selector(alertView:clickedButtonAtIndex:) fromProtocol:@protocol(UIAlertViewDelegate)] subscribeNext:^(RACTuple *tuple) {
        NSLog(@"%@",tuple.first);
        NSLog(@"%@",tuple.second);
        NSLog(@"%@",tuple.third);
    }];
    [alertView show];
}

@end
