//
//  JRListViewModel.h
//  MVVM_RACDemo
//
//  Created by yangln on 2019/6/3.
//  Copyright © 2019 yangln. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JRListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JRListViewModel : NSObject

@property (nonatomic, strong) RACCommand *racCommand;
@property (nonatomic, strong) RACSubject *racSubject;
@property (nonatomic, strong) NSMutableArray <JRListModel *>*dataArray;

- (void)loadData;

@end

NS_ASSUME_NONNULL_END
