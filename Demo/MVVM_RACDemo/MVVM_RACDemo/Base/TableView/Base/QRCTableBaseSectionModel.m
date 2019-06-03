//
//  QRCTableBaseSectionModel.m
//  QiyiDemo
//
//  Created by yanglunan on 2019/4/11.
//  Copyright © 2019 yanglunan. All rights reserved.
//

#import "QRCTableBaseSectionModel.h"

@implementation QRCTableBaseSectionModel

- (id)initSectionWithHeaderModel:(id)headerModel footerModel:(id)footerModel cellModels:(NSArray *)cellModels {
    self = [super init];
    if (self) {
        self.headerModel = headerModel;
        self.footerModel = footerModel;
        self.cellModels = cellModels;
    }
    return self;
}

@end
