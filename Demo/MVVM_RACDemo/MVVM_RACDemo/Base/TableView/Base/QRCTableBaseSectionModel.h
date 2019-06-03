//
//  QRCTableBaseSectionModel.h
//  QiyiDemo
//
//  Created by yanglunan on 2019/4/11.
//  Copyright © 2019 yanglunan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QRCTableBaseSectionModel : NSObject

@property (nonatomic, strong) id headerModel;
@property (nonatomic, strong) id footerModel;
@property (nonatomic, strong) NSArray *cellModels;
@property (nonatomic, strong) Class viewClass;

- (id)initSectionWithHeaderModel:(id)headerModel footerModel:(id)footerModel cellModels:(NSArray *)cellModels;

@end

NS_ASSUME_NONNULL_END
