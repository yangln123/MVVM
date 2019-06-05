//
//  JRAppRACViewController.m
//  MVVM_RACDemo
//
//  Created by yangln on 2019/5/30.
//  Copyright © 2019 yangln. All rights reserved.
//

#import "JRAppRACViewController.h"
#import "JRListViewController.h"
#import "JRLoginViewModel.h"

@interface JRAppRACViewController ()

@property (nonatomic, strong) UITextField *nameField;
@property (nonatomic, strong) UITextField *passwordField;
@property (nonatomic, strong) JRUIButton *loginBtn;
@property (nonatomic, strong) JRLoginViewModel *loginViewModel;

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
    field.textColor = [UIColor blackColor];
    field.font = [UIFont systemFontOfSize:18.0];
    field.textAlignment = NSTextAlignmentLeft;
    field.maxLength = 10;
    @weakify(self)
    [field setMaxAction:^{
        @strongify(self)
        [self handleHud];
    }];
    
    return field;
}

- (void)handleHud {
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:hud];
    hud.label.text = @"超过最大可输入长度";
    hud.mode = MBProgressHUDModeText;
    [hud showAnimated:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [hud hideAnimated:YES];
    });
}


- (JRUIButton *)loginBtn {
    if (!_loginBtn) {
        _loginBtn = [JRUIButton buttonWithType:UIButtonTypeCustom];
        [_loginBtn setTitle:@"Login" forState:UIControlStateNormal];
        [_loginBtn setTitle:@"Login" forState:UIControlStateHighlighted];
        _loginBtn.userInteractionEnabled = NO;
        [_loginBtn addTarget:self action:@selector(loginSuccess:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}

- (void)loginSuccess:(id)sender {
    [self.loginViewModel.racCommand execute:@"login"];
}

#pragma mark bind
- (void)bindRAC {
    self.loginViewModel = [[JRLoginViewModel alloc] init];
    RAC(self.loginViewModel, userName) = self.nameField.rac_textSignal;
    RAC(self.loginViewModel, password) = self.passwordField.rac_textSignal;
    
    @weakify(self)
    [self.loginViewModel handleSignalWithComplete:^(BOOL enable) {
        @strongify(self)
        self.loginBtn.userInteractionEnabled = enable;
        [self.loginBtn setTitleColor:enable ? [UIColor redColor] : [UIColor whiteColor] forState:UIControlStateNormal];
        [self.loginBtn setBackgroundColor:enable ? [UIColor grayColor] : [UIColor lightGrayColor]];
    }];
    
    [self.loginViewModel.successSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        JRListViewController *vc = [[JRListViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
}


@end
