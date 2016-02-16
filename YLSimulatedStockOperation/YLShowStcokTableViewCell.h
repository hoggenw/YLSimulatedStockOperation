//
//  YLShowStcokTableViewCell.h
//  YLSimulatedStockOperation
//
//  Created by 千锋 on 16/2/16.
//  Copyright © 2016年 hoggenWang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YLMarketIndexModel;
@interface YLShowStcokTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UILabel *stockLabel;
@property (weak, nonatomic) IBOutlet UILabel *stockPrice;
@property (weak, nonatomic) IBOutlet UILabel *stockChagnePercent;
@property(nonatomic,strong)YLMarketIndexModel *model;
@end
