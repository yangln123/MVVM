//
//  JRBaseViewController.m
//  MVVM_RACDemo
//
//  Created by yangln on 2019/5/30.
//  Copyright © 2019 yangln. All rights reserved.
//

#import "JRBaseViewController.h"

@interface JRBaseViewController ()

@end

@implementation JRBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
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

- (void)hanleAction:(UIButton *)button {
    
}


@end
