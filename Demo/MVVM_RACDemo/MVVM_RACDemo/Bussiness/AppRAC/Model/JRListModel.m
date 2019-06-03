//
//  JRListModel.m
//  MVVM_RACDemo
//
//  Created by yangln on 2019/6/3.
//  Copyright © 2019 yangln. All rights reserved.
//

#import "JRListModel.h"

@implementation JRListModel

- (id)initWithText:(NSString *)text {
    self = [super initWithText:text];
    if (self) {
        self.text = text;
    }
    return self;
}

@end
