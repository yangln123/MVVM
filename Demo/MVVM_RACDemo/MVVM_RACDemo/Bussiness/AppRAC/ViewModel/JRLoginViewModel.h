//
//  JRLoginViewModel.h
//  MVVM_RACDemo
//
//  Created by yangln on 2019/6/5.
//  Copyright © 2019 yangln. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JRUserModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JRLoginViewModel : NSObject

@property (nonatomic, strong) JRUserModel *userModel;
@property (nonatomic, strong) RACCommand *racCommand;

@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) RACSubject *successSubject;

- (void)handleSignalWithComplete:(void(^)(BOOL enable))complete;

@end

NS_ASSUME_NONNULL_END
