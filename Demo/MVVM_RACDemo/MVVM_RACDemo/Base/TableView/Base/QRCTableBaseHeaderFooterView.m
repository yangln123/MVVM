//
//  QRCTableBaseHeaderFooterView.m
//  QiyiDemo
//
//  Created by yanglunan on 2019/4/11.
//  Copyright © 2019 yanglunan. All rights reserved.
//

#import "QRCTableBaseHeaderFooterView.h"

@implementation QRCTableBaseHeaderFooterView

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    return [super initWithReuseIdentifier:NSStringFromClass([self class])];
}

- (CGFloat)getHeight {
    return 0.0;
}

- (void)setHeadFooterModel:(id)model {
    
}

@end
