//
//  YLDealStockTableViewCell.m
//  YLSimulatedStockOperation
//
//  Created by 千锋 on 16/2/18.
//  Copyright © 2016年 hoggenWang. All rights reserved.
//

#import "YLDealStockTableViewCell.h"
#import "YLBuyStockModel.h"
@implementation YLDealStockTableViewCell
-(void)setModel:(YLBuyStockModel *)model{
    _stockName.text=model.stockName;
    _dealPrice.text=model.buyPrice;
    _dealNumber.text=model.buyNumber;
    if (model.ifTrade==1) {
        _dealSucces.text=@"是";
    }else{
        _dealSucces.text=@"否";
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
