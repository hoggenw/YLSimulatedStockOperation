//
//  YLNewsTableViewCell.m
//  YLSimulatedStockOperation
//
//  Created by 千锋 on 16/2/15.
//  Copyright © 2016年 hoggenWang. All rights reserved.
//

#import "YLNewsTableViewCell.h"
#import "YLFastNewsModel.h"
@implementation YLNewsTableViewCell


-(void)setModel:(YLFastNewsModel *)model{
    _model=model;
    _titleLabel.text=model.n_title;
    _detailLabel.text=model.n_Abstract;
    _timeLabe.text=model.date;
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
