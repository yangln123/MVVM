//
//  JRListTableViewCell.m
//  MVVM_RACDemo
//
//  Created by yangln on 2019/6/3.
//  Copyright © 2019 yangln. All rights reserved.
//

#import "JRListTableViewCell.h"
#import "JRListModel.h"

@implementation JRListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (CGFloat)getHeight {
    return 60.0;
}

- (void)setCellModel:(id)model {
    JRListModel *jrModel = model;
    self.textLabel.text = jrModel.text;
}

@end
