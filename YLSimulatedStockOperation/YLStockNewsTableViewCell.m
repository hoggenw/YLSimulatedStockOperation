//
//  YLStockNewsTableViewCell.m
//  YLSimulatedStockOperation
//
//  Created by 千锋 on 16/2/16.
//  Copyright © 2016年 hoggenWang. All rights reserved.
//

#import "YLStockNewsTableViewCell.h"
#import "YLStockNewsModel.h"
@implementation YLStockNewsTableViewCell
-(void)setModel:(YLStockNewsModel *)model{
    _newsTitle.text=model.title;
    _dateString.text=model.date;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
