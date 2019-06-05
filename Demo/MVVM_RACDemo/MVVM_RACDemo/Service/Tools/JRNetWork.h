//
//  JRNetWork.h
//  MVVM_RACDemo
//
//  Created by yangln on 2019/6/5.
//  Copyright © 2019 yangln. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JRNetWork : NSObject

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
