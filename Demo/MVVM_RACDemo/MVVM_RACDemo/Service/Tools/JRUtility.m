//
//  JRUtility.m
//  MVVM_RACDemo
//
//  Created by yangln on 2019/5/30.
//  Copyright © 2019 yangln. All rights reserved.
//

#import "JRUtility.h"

@implementation JRUtility

+ (NSDictionary *)createrSelectersWithKeys:(id)firstSelector, ... {
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    va_list args;
    va_start(args, firstSelector);
    id startSelector = firstSelector;
    while (startSelector) {
        [dict setValue:startSelector forKey:va_arg(args, id)];
        startSelector = va_arg(args, id);
    }
    va_end(args);
    
    return dict;
}

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
