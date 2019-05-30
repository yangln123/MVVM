//
//  ViewController.m
//  MVVM_RACDemo
//
//  Created by yangln on 2019/5/30.
//  Copyright © 2019 yangln. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property(nonatomic, strong) JRUIButton *useButton;
@property (nonatomic, strong) JRUIButton *appButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.useButton];
    [self.view addSubview:self.appButton];
}

- (JRUIButton *)useButton {
    if (!_useButton) {
        _useButton = [self createButtonWithTitle:@"简单使用" tag:0];
    }
    return _useButton;
}

- (JRUIButton *)appButton {
    if (!_appButton) {
        _appButton = [self createButtonWithTitle:@"项目应用" tag:1];
    }
    return _appButton;
}

- (JRUIButton *)createButtonWithTitle:(NSString *)title tag:(NSInteger)tag {
    JRUIButton *button = [JRUIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100.0, 100 + tag * 80.0, 160.0, 60.0);
    button.backgroundColor = [UIColor lightGrayColor];
    [button setTitle:title forState:UIControlStateNormal];
    button.tag = tag;
    [button addTarget:self action:@selector(hanleAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

- (void)hanleAction:(JRUIButton *)button {
    if (button.tag == 0) {
        
    }
    else if (button.tag == 1) {
        
    }
}


@end
