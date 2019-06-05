//
//  JRUtility.m
//  MVVM_RACDemo
//
//  Created by yangln on 2019/5/30.
//  Copyright © 2019 yangln. All rights reserved.
//

#import "JRUtility.h"

@implementation JRUtility

+ (instancetype)sharedInstance {
    static JRUtility *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[JRUtility alloc] init];
    });
    return instance;
}

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


@end
