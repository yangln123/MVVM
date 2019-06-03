//
//  QRCTableBaseHeaderFooterView.h
//  QiyiDemo
//
//  Created by yanglunan on 2019/4/11.
//  Copyright © 2019 yanglunan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface QRCTableBaseHeaderFooterView : UITableViewHeaderFooterView

- (CGFloat)getHeight;

- (void)setHeadFooterModel:(id)model;

@end

NS_ASSUME_NONNULL_END
