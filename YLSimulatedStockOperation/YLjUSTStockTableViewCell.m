//
//  YLjUSTStockTableViewCell.m
//  YLSimulatedStockOperation
//
//  Created by 千锋 on 16/2/17.
//  Copyright © 2016年 hoggenWang. All rights reserved.
//

#import "YLjUSTStockTableViewCell.h"
#import "YLMarketIndexModel.h"
@implementation YLjUSTStockTableViewCell

-(void)setModel:(YLMarketIndexModel *)model{
    _nameLabel.text=model.marketName;
    _priceLabel.text=model.marketCount;
    _percentLabel.text=[NSString stringWithFormat:@"%.2lf%%",[model.changePercent doubleValue]];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
