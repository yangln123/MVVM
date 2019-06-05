//
//  JRLoginViewModel.m
//  MVVM_RACDemo
//
//  Created by yangln on 2019/6/5.
//  Copyright © 2019 yangln. All rights reserved.
//

#import "JRLoginViewModel.h"

@interface JRLoginViewModel ()

@property (nonatomic, strong) RACSignal *userSignal;
@property (nonatomic, strong) RACSignal *passwordSignal;
@property (nonatomic, strong) RACSignal *loginSignal;

@end

@implementation JRLoginViewModel

- (id)init {
    self = [super init];
    if (self) {
        self.userSignal = RACObserve(self, self.userName);
        self.passwordSignal = RACObserve(self, self.password);
        self.successSubject = [RACSubject subject];
        [self handleCommand];
    }
    return self;
}

- (RACCommand *)racCommand {
    if (!_racCommand) {
        _racCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:NO];
                    [subscriber sendNext:@"data"];
                    [subscriber sendCompleted];//必须，否则不能再次发送
                });
                return nil;
            }];
        }];
    }
    return _racCommand;
}

- (void)handleSignalWithComplete:(void(^)(BOOL enable))complete {
    @weakify(self)
    [[RACSignal combineLatest:@[self.userSignal, self.passwordSignal] reduce:^(NSString *userName, NSString *password){
        @strongify(self)
        return @([self isValid:userName] && [self isValid:password]);
    }] subscribeNext:^(id  _Nullable x) {
        if (complete) {
            complete([x boolValue]);
        }
    }];
}

- (void)handleCommand {
    @weakify(self)
    [[[self.racCommand executionSignals] switchToLatest] subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.successSubject sendNext:x];
    }];
}

- (BOOL)isValid:(NSString *)str {
    NSString *regularStr = @"[a-zA-Z0-9_]{6,10}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", regularStr];
    return [predicate evaluateWithObject:str];
}

@end
