//
//  YLjUSTStockTableViewCell.h
//  YLSimulatedStockOperation
//
//  Created by 千锋 on 16/2/17.
//  Copyright © 2016年 hoggenWang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YLMarketIndexModel;
@interface YLjUSTStockTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *percentLabel;
@property(nonatomic,strong)YLMarketIndexModel *model;
@end
