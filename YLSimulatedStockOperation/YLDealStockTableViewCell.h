//
//  YLDealStockTableViewCell.h
//  YLSimulatedStockOperation
//
//  Created by 千锋 on 16/2/18.
//  Copyright © 2016年 hoggenWang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YLBuyStockModel;
@interface YLDealStockTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *stockName;
@property (weak, nonatomic) IBOutlet UILabel *dealPrice;
@property (weak, nonatomic) IBOutlet UILabel *dealNumber;
@property (weak, nonatomic) IBOutlet UILabel *dealSucces;
@property(nonatomic,strong)YLBuyStockModel *model;
@end
