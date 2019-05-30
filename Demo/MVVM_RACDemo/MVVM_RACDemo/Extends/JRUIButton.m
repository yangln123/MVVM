//
//  JRUIButton.m
//  DragDemo
//
//  Created by yangln on 2019/5/27.
//  Copyright © 2019 yangln. All rights reserved.
//

#import "JRUIButton.h"

@implementation JRUIButton

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    CGRect responseRect = self.frame;
    responseRect.origin.x -= _responseInsets.left;
    responseRect.origin.y -= _responseInsets.top;
    responseRect.size.width += (_responseInsets.left + _responseInsets.right);
    responseRect.size.height += (_responseInsets.top + _responseInsets.bottom);
    
    CGPoint parentLocation = [self convertPoint:point toView:[self superview]];
    BOOL result = CGRectContainsPoint(responseRect, parentLocation);
    return result;
}

@end
