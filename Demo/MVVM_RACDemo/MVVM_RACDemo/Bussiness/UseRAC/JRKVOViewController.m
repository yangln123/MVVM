//
//  JRKVORACViewController.m
//  MVVM_RACDemo
//
//  Created by yangln on 2019/5/31.
//  Copyright © 2019 yangln. All rights reserved.
//

#import "JRKVOViewController.h"

@interface JRKVOViewController ()

@end

@implementation JRKVOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addScrollView];
}

- (void)addScrollView {
    UIScrollView *scrolView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 200, 400)];
    scrolView.contentSize = CGSizeMake(200, 800);
    scrolView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:scrolView];
    
    [RACObserve(scrolView, contentOffset) subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    
//    [[scrolView rac_valuesForKeyPath:@"contentOffset" observer:self] subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@", x);
//    }];
    
//    [scrolView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
//    NSLog(@"%@", change);
//}

@end
