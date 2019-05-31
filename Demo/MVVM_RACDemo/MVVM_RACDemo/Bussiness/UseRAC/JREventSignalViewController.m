//
//  JREventSignalViewController.m
//  MVVM_RACDemo
//
//  Created by yangln on 2019/5/31.
//  Copyright © 2019 yangln. All rights reserved.
//

#import "JREventSignalViewController.h"

@interface JREventSignalViewController ()

@end

@implementation JREventSignalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self handleMergeSignal];
    [self handleReduce];
    [self handleNext];
}

//信号合并
- (void)handleMergeSignal {
    RACSignal *signalA = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@"A"];
        return nil;
    }];
    RACSignal *signalB = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@"B"];
        return nil;
    }];
    RACSignal *mergeSignal = [signalA merge:signalB];
    [mergeSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
}

//信号聚合
- (void)handleReduce {
    RACSignal *signalA = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@"A"];
        return nil;
    }];
    RACSignal *signalB = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@"B"];
        return nil;
    }];
    RACSignal *reduceSignal = [RACSignal combineLatest:@[signalA, signalB] reduce:^id (NSNumber *a, NSNumber *b){
        return [NSString stringWithFormat:@"%@ - %@", a, b];
    }];
    [reduceSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
}

- (void)handleNext {
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@1];
        [subscriber sendCompleted];
        return nil;
    }];
    RACSignal *signaleThen = [signal then:^RACSignal * {
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            //可以对第一个信号的数据进行过滤处理 , 不能直接获得第一个信号的数据返回值
            [subscriber sendNext:@2];
            return nil;
        }];
    }];
    [signaleThen subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
    
//    [[[RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//        [subscriber sendNext:@1];
//        [subscriber sendCompleted];
//        return nil;
//    }] then:^RACSignal *{
//        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//            //可以对第一个信号的数据进行过滤处理 , 不能直接获得第一个信号的数据返回值
//            [subscriber sendNext:@2];
//            return nil;
//        }];
//    }] subscribeNext:^(id x) {
//        // 只能接收到第二个信号的值，也就是then返回信号的值
//        NSLog(@"then : %@",x); // 2
//    }];
}

@end
