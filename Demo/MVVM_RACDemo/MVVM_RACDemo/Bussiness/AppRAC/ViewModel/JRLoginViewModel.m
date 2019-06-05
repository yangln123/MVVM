//
//  JRLoginViewModel.m
//  MVVM_RACDemo
//
//  Created by yangln on 2019/6/5.
//  Copyright © 2019 yangln. All rights reserved.
//

#import "JRLoginViewModel.h"
#import "JRListViewController.h"

@implementation JRLoginViewModel

- (id)initWithNameField:(UITextField *)nameField passwordField:(UITextField *)passwordField loginBtn:(JRUIButton *)loginBtn {
    self = [super init];
    if (self) {
        @weakify(self)
        RACSignal *nameSignal = [nameField.rac_textSignal map:^id _Nullable(NSString * _Nullable value) {
            @strongify(self);
            return @([self isValid:value]);
        }];
        RACSignal *passwordSignal = [passwordField.rac_textSignal map:^id _Nullable(NSString * _Nullable value) {
            @strongify(self)
            return @([self isValid: value]);
        }];
        
        [[RACSignal combineLatest:@[nameSignal, passwordSignal] reduce:^(id first, id second){
            return @([first boolValue] && [second boolValue]);
        }] subscribeNext:^(id  _Nullable x) {
            loginBtn.userInteractionEnabled = [x boolValue];
            [loginBtn setTitleColor:[x boolValue] ? [UIColor redColor] : [UIColor whiteColor] forState:UIControlStateNormal];
            [loginBtn setBackgroundColor:[x boolValue] ? [UIColor grayColor] : [UIColor lightGrayColor]];
        }];
        
        [self handleCommand];
    }
    return self;
}

- (BOOL)isValid:(NSString *)str {
    NSString *regularStr = @"[a-zA-Z0-9_]{6,10}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", regularStr];
    return [predicate evaluateWithObject:str];
}

- (RACCommand *)racCommand {
    if (!_racCommand) {
        _racCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
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

- (void)handleCommand {
    [[[self.racCommand executionSignals] switchToLatest] subscribeNext:^(id  _Nullable x) {
        JRListViewController *vc = [[JRListViewController alloc] init];
        [[JRUtility sharedInstance].navigationController pushViewController:vc animated:YES];
    }];
}

@end
