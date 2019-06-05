//
//  JRNetViewController.m
//  MVVM_RACDemo
//
//  Created by yangln on 2019/5/31.
//  Copyright © 2019 yangln. All rights reserved.
//

#import "JRNetViewController.h"

@interface JRNetViewController ()

@property (nonatomic, strong) RACCommand *netCommand;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) RACCommand *command;

@end

@implementation JRNetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.imageView];
    
    [[self.netCommand executionSignals].switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
        if ([x isKindOfClass:[UIImage class]]) {
            UIImage *image = (UIImage *)x;
            self.imageView.image = image;
            self.imageView.size = image.size;
        }
    }];
    [self.netCommand execute:@"send begin"];
    
    
//    [self.netCommand.executionSignals subscribeNext:^(id  _Nullable x) {
//        NSLog(@"yln==%@", x);
//        [x subscribeNext:^(id  _Nullable x) {
//            if ([x isKindOfClass:[UIImage class]]) {
//                UIImage *image = (UIImage *)x;
//                self.imageView.image = image;
//                self.imageView.size = image.size;
//            }
//        }];
//    }];
//    [self.netCommand execute:@"send begin"];
    
    
//    RACSignal *signal = [self.netCommand execute:@"send begin"];
//    [signal subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@", x);
//        if ([x isKindOfClass:[UIImage class]]) {
//            UIImage *image = (UIImage *)x;
//            self.imageView.image = image;
//            self.imageView.size = image.size;
//        }
//    }];
    
}

- (RACCommand *)netCommand {
    if (!_netCommand) {
        _netCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//                [JRNetWork sendGetRequestWithUrl:@"https://img2.vipcn.com/img2017/6/30/2017063009549889.jpg" params:@{} finish:^(id  _Nonnull data, NSError * _Nonnull error) {
//                    if (!error) {
//                        [subscriber sendNext:data];
//                    }
//                    else {
//                        [subscriber sendError:error];
//                    }
//                    [subscriber sendCompleted];//必须，否则不能再次发送
//                }];
                
                [self.imageView sd_setImageWithURL:[NSURL URLWithString:@"https://img2.vipcn.com/img2017/6/30/2017063009549889.jpg"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                    if (image) {
                        [subscriber sendNext:image];
                    }
                    else {
                        [subscriber sendError:error];
                    }
                    [subscriber sendCompleted];//必须，否则不能再次发送
                }];
                return nil;
            }];
        }];
    }
    return _netCommand;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, 0, 0)];
    }
    return _imageView;
}


//-(RACCommand*)command{
//    if(!_command){
//        _command= [[RACCommand alloc]initWithSignalBlock:^RACSignal*(id input) {
//            NSLog(@"收到执行命令%@",input);
//            return[RACSignal createSignal:^RACDisposable*(id subscriber) {
//                NSLog(@"正在加载.........");
//                [subscriber sendNext:@"数据"];
//                [subscriber sendCompleted];
//                return nil;
//            }];
//        }];
//    }
//    return _command;
//}

@end
