//
//  JRLoginView.m
//  MVVM_RACDemo
//
//  Created by yangln on 2019/6/3.
//  Copyright © 2019 yangln. All rights reserved.
//

#import "JRLoginView.h"

@interface JRLoginView ()

@property (nonatomic, strong) UITextField *nameField;
@property (nonatomic, strong) UITextField *passwordField;
@property (nonatomic, strong) JRUIButton *loginBtn;

@end

@implementation JRLoginView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.nameField];
        [self addSubview:self.passwordField];
        [self addSubview:self.loginBtn];
        [self setSubViewsConstrains];
    }
    return self;
}

- (void)setSubViewsConstrains {
    
}

- (UITextField *)nameField {
    if (!_nameField) {
        
    }
    return _nameField;
}

- (UITextField *)passwordField {
    if (!_passwordField) {
        
    }
    return _passwordField;
}

- (JRUIButton *)loginBtn {
    if (!_loginBtn) {
        _loginBtn = [JRUIButton buttonWithType:UIButtonTypeCustom];
        [_loginBtn setTitle:@"Login" forState:UIControlStateNormal];
    }
    return _loginBtn;
}

@end
