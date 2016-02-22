//
//  YLRevokeTableViewCell.m
//  YLSimulatedStockOperation
//
//  Created by 千锋 on 16/2/19.
//  Copyright © 2016年 hoggenWang. All rights reserved.
//

#import "YLRevokeTableViewCell.h"
#import "YLBuyStockModel.h"
@implementation YLRevokeTableViewCell

-(void)setModel:(YLBuyStockModel *)model{
    _model=model;
    _stockNane.text=model.stockName;
    _stockPrice.text=model.buyPrice;
    _stockNumbers.text=model.buyNumber;
    if (model.ifSell) {
        _buyOrSell.text=@"卖出";
        
    }else{
        _buyOrSell.text=@"买入";
    }
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
