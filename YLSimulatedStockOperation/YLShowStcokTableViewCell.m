//
//  YLShowStcokTableViewCell.m
//  YLSimulatedStockOperation
//
//  Created by 千锋 on 16/2/16.
//  Copyright © 2016年 hoggenWang. All rights reserved.
//

#import "YLShowStcokTableViewCell.h"
#import "YLMarketIndexModel.h"
@implementation YLShowStcokTableViewCell
-(void)setModel:(YLMarketIndexModel *)model{
    _stockLabel.text=model.marketName;
    _stockPrice.text=[NSString stringWithFormat:@"%.2lf", [model.marketCount doubleValue]];
    _stockChagnePercent.text=[NSString stringWithFormat:@"%.2lf%%",[model.changePercent doubleValue]];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
