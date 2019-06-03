//
//  QRCTableBaseCellModel.h
//  QiyiDemo
//
//  Created by yanglunan on 2019/4/16.
//  Copyright © 2019 yanglunan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QRCTableBaseCellModel : NSObject

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) Class viewClass;

- (id)initWithText:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
