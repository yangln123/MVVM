//
//  JRUtility.h
//  MVVM_RACDemo
//
//  Created by yangln on 2019/5/30.
//  Copyright © 2019 yangln. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JRUtility : NSObject


/**
 创建函数映射字典
 @param firstSelector 参数
 */
+ (NSDictionary *)createrSelectersWithKeys:(id)firstSelector, ... NS_REQUIRES_NIL_TERMINATION;

/**
 发送get请求
 @param url 链接
 @param params 参数
 @param finish 返回block
 */
+ (void)sendGetRequestWithUrl:(NSString *)url params:(NSDictionary *)params finish:(void(^)(id data, NSError *error))finish;

/**
 发送post请求
 @param url 链接
 @param params 参数
 @param finish 返回block
 */
+ (void)sendPostRequestWithUrl:(NSString *)url params:(NSDictionary *)params finish:(void(^)(id data, NSError *error))finish;

@end

NS_ASSUME_NONNULL_END
