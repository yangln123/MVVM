//
//  QRCBaseTableViewCell.h
//  QiyiDemo
//
//  Created by yanglunan on 2019/4/11.
//  Copyright © 2019 yanglunan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^cellBlock)(id model);

@interface QRCBaseTableViewCell : UITableViewCell

@property (nonatomic, copy) cellBlock configCell;

- (CGFloat)getHeight;

- (void)setCellModel:(id)model;

@end

NS_ASSUME_NONNULL_END
