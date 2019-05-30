//
//  JRUseRACViewController.m
//  MVVM_RACDemo
//
//  Created by yangln on 2019/5/30.
//  Copyright © 2019 yangln. All rights reserved.
//

#import "JRUseRACViewController.h"

@interface JRUseRACViewController ()

@end

@implementation JRUseRACViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"RAC使用";
    [self racUses];
}

- (void)racUses {
    [self racNormalUse];
    [self racUIKitUse];
    [self racFoundationUse];
    [self racKVOUse];
    [self racSignalUse];
    [self racNetUse];
}

#pragma mark Normal
- (void)racNormalUse {
    
}

#pragma mark UIKit
- (void)racUIKitUse {
    
}

#pragma mark UIFoundation
- (void)racFoundationUse {
    
}

#pragma mark KVO
- (void)racKVOUse {
    
}

#pragma mark Signal
- (void)racSignalUse {
    
}

#pragma mark Net
- (void)racNetUse {
    
}

@end
