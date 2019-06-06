//
//  UIGestureRecognizer+Associator.m
//  MVVM_RACDemo
//
//  Created by yangln on 2019/6/6.
//  Copyright © 2019 yangln. All rights reserved.
//

#import "UIGestureRecognizer+Associator.h"
 #import <objc/runtime.h>
#import <objc/message.h>

@implementation UIGestureRecognizer (Associator)

void swizzleClassInstanceMethod(Class cls, SEL originSel, SEL swizzleSel) {
    Method originMethod = class_getInstanceMethod(cls, originSel);
    Method swizzleMethod = class_getInstanceMethod(cls, swizzleSel);
    BOOL didAdd = class_addMethod(cls, originSel, method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod));
    if (didAdd) {
        class_replaceMethod(cls, swizzleSel, method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
    }
    else {
        method_exchangeImplementations(originMethod, swizzleMethod);
    }
}

+ (void)load {
    swizzleClassInstanceMethod(self, @selector(initWithTarget:action:), @selector(newInitWithTarget:action:));
}

- (instancetype)newInitWithTarget:(nullable id)target action:(nullable SEL)action {
    UIGestureRecognizer *gestureRecognizer = [self newInitWithTarget:target action:action];
    
    if (!target && !action) {
        return gestureRecognizer;
    }
    
    if ([target isKindOfClass:[UIScrollView class]]) {
        return gestureRecognizer;
    }
    
    Class class = [target class];
    SEL oldSel = action;
    SEL addSel = NULL;
    
    if ([gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]] || [gestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]]){
        // 首先动态添加一个新方法
        addSel = NSSelectorFromString([NSString stringWithFormat:@"vi_%@", NSStringFromSelector(action)]);
    }
    
    if ([target respondsToSelector:oldSel] && oldSel && addSel && [self isMethodOverride:class selector:oldSel]) {
        BOOL isAddMethod = class_addMethod(class, addSel, (IMP)jr_RespondBuryCollectGestureAction, "v@:@");
        if (isAddMethod) {
            swizzleClassInstanceMethod(class, oldSel, addSel);
        }
    }
    
    return gestureRecognizer;
}

void jr_RespondBuryCollectGestureAction(id self, SEL _cmd, id sender) {
    NSString *SELStr = [NSString stringWithFormat:@"vi_%@", NSStringFromSelector(_cmd)];
    SEL swizzledSEL = NSSelectorFromString(SELStr);
    ((void(*)(id, SEL, id))objc_msgSend)(self, swizzledSEL, sender);
}

- (BOOL)isMethodOverride:(Class)cls selector:(SEL)sel {
    Method clsMethod = class_getInstanceMethod(cls, sel);
    Method superClsMethod = class_getInstanceMethod([cls superclass], sel);
    return clsMethod != superClsMethod;
}

@end
