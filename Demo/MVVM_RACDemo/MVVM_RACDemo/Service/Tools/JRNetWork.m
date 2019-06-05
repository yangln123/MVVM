//
//  JRNetWork.m
//  MVVM_RACDemo
//
//  Created by yangln on 2019/6/5.
//  Copyright © 2019 yangln. All rights reserved.
//

#import "JRNetWork.h"

@implementation JRNetWork

+ (void)sendGetRequestWithUrl:(NSString *)url params:(NSDictionary *)params finish:(void(^)(id data, NSError *error))finish {
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.validatesDomainName = NO;
    securityPolicy.allowInvalidCertificates = YES;
    
    [AFHTTPSessionManager manager].securityPolicy = securityPolicy;
    
    [[AFHTTPSessionManager manager] GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (finish) {
            finish(responseObject, nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (finish) {
            finish(nil, error);
        }
    }];
}

+ (void)sendPostRequestWithUrl:(NSString *)url params:(NSDictionary *)params finish:(void(^)(id data, NSError *error))finish {
    [[AFHTTPSessionManager manager] POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (finish) {
            finish(responseObject, nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (finish) {
            finish(nil, error);
        }
    }];
}

@end
