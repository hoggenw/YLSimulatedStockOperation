//
//  YLSellOutTableViewCell.m
//  YLSimulatedStockOperation
//
//  Created by 千锋 on 16/2/19.
//  Copyright © 2016年 hoggenWang. All rights reserved.
//

#import "YLSellOutTableViewCell.h"
#import "YLBuyStockModel.h"
@implementation YLSellOutTableViewCell


-(void)setModel:(YLBuyStockModel *)model{
    _model=model;
    _stockNane.text=model.stockName;
    _buyPrice.text=model.buyPrice;
    _buyNumber.text=model.buyNumber;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
