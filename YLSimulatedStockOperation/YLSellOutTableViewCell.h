//
//  YLSellOutTableViewCell.h
//  YLSimulatedStockOperation
//
//  Created by 千锋 on 16/2/19.
//  Copyright © 2016年 hoggenWang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YLBuyStockModel;
@interface YLSellOutTableViewCell : UITableViewCell
@property(nonatomic ,strong)YLBuyStockModel *model;
@property (weak, nonatomic) IBOutlet UILabel *stockNane;
@property (weak, nonatomic) IBOutlet UILabel *buyPrice;
@property (weak, nonatomic) IBOutlet UILabel *buyNumber;
@property (weak, nonatomic) IBOutlet UIButton *sellButton;

@end
