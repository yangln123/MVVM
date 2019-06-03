//
//  JRAppRACViewController.m
//  MVVM_RACDemo
//
//  Created by yangln on 2019/5/30.
//  Copyright © 2019 yangln. All rights reserved.
//

#import "JRAppRACViewController.h"

@interface JRAppRACViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *nameField;
@property (nonatomic, strong) UITextField *passwordField;
@property (nonatomic, strong) JRUIButton *loginBtn;

@end

@implementation JRAppRACViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Login";

    [self configureSubViews];
    [self bindRAC];
}

#pragma mark init
- (void)configureSubViews {
    [self.view addSubview:self.nameField];
    [self.view addSubview:self.passwordField];
    [self.view addSubview:self.loginBtn];
    
    [self.nameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(200.0);
        make.left.mas_equalTo(36.0);
        make.width.mas_equalTo(JRScreenWidth - 72.0);
        make.height.mas_equalTo(48.0);
    }];
    [self.passwordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.nameField);
        make.top.equalTo(self.nameField.mas_bottom).offset(20.0);
    }];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(64.0);
        make.width.mas_equalTo(JRScreenWidth - 128.0);
        make.height.equalTo(self.passwordField);
        make.top.equalTo(self.passwordField.mas_bottom).offset(20.0);
    }];
}

- (UITextField *)nameField {
    if (!_nameField) {
        _nameField = [self createTextField];
        _nameField.placeholder = @"请输入用户名";
    }
    return _nameField;
}

- (UITextField *)passwordField {
    if (!_passwordField) {
        _passwordField = [self createTextField];
        _passwordField.placeholder = @"请输入密码";
        _passwordField.secureTextEntry = YES;
    }
    return _passwordField;
}

- (UITextField *)createTextField {
    UITextField *field = [[UITextField alloc] init];
    field.backgroundColor = [UIColor lightGrayColor];
    field.delegate = self;
    field.textColor = [UIColor blackColor];
    field.font = [UIFont systemFontOfSize:18.0];
    field.textAlignment = NSTextAlignmentLeft;
    
    return field;
}

- (JRUIButton *)loginBtn {
    if (!_loginBtn) {
        _loginBtn = [JRUIButton buttonWithType:UIButtonTypeCustom];
        [_loginBtn setTitle:@"Login" forState:UIControlStateNormal];
        [_loginBtn setTitle:@"Login" forState:UIControlStateHighlighted];
        _loginBtn.userInteractionEnabled = NO;
    }
    return _loginBtn;
}

#pragma mark bind
- (void)bindRAC {
    @weakify(self)
    RACSignal *nameSignal = [self.nameField.rac_textSignal map:^id _Nullable(NSString * _Nullable value) {
        @strongify(self);
        return @([self isValid:value]);
    }];
    RACSignal *passwordSignal = [self.passwordField.rac_textSignal map:^id _Nullable(NSString * _Nullable value) {
        @strongify(self)
        return @([self isValid: value]);
    }];
    
    [[RACSignal combineLatest:@[nameSignal, passwordSignal] reduce:^(id first, id second){
        return @([first boolValue] && [second boolValue]);
    }] subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        self.loginBtn.userInteractionEnabled = [x boolValue];
        [self.loginBtn setTitleColor:[x boolValue] ? [UIColor redColor] : [UIColor whiteColor] forState:UIControlStateNormal];
        [self.loginBtn setBackgroundColor:[x boolValue] ? [UIColor grayColor] : [UIColor lightGrayColor]];
    }] ;
}

- (BOOL)isValid:(NSString *)str {
    NSString *regularStr = @"[a-zA-Z0-9_]{6,16}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", regularStr];
    return [predicate evaluateWithObject:str];
}

#pragma mark textField delegate


@end
