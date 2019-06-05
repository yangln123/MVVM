//
//  UITextField+Extention.m
//  MVVM_RACDemo
//
//  Created by yangln on 2019/6/5.
//  Copyright © 2019 yangln. All rights reserved.
//

#import "UITextField+Extention.h"
#import <objc/runtime.h>

static NSString *KMaxLengthKey;
static NSString *kMaxActionKey;

@implementation UITextField (Extention)

+ (void)load {
    Method originMethod = class_getInstanceMethod([self class], @selector(initWithFrame:));
    Method newMethod = class_getInstanceMethod([self class], @selector(adapterInitWithFrame:));
    method_exchangeImplementations(originMethod, newMethod);
}

- (id)adapterInitWithFrame:(CGRect)frame {
    [self adapterInitWithFrame:frame];
    if (self) {
        [self addLengthObserverEvent];
    }
    return self;
}

- (void)addLengthObserverEvent {
    [self addTarget:self action:@selector(valueChange) forControlEvents:UIControlEventEditingChanged];
}

- (void)valueChange {
    if (self.maxLength && self.text.length > self.maxLength) {
        self.text = [self.text substringToIndex:self.maxLength];
        if (self.maxAction) {
            self.maxAction();
        }
    }
}

- (void)setMaxLength:(NSInteger)maxLength {
    objc_setAssociatedObject(self, &KMaxLengthKey, @(maxLength), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSInteger)maxLength {
    NSNumber *number = objc_getAssociatedObject(self, &KMaxLengthKey);
    return [number integerValue];
}

- (void)setMaxAction:(ActionBlock)maxAction {
    objc_setAssociatedObject(self, &kMaxActionKey, maxAction, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (ActionBlock)maxAction {
    return objc_getAssociatedObject(self, &kMaxActionKey);
}

@end
