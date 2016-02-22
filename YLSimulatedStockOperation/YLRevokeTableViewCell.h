//
//  YLRevokeTableViewCell.h
//  YLSimulatedStockOperation
//
//  Created by 千锋 on 16/2/19.
//  Copyright © 2016年 hoggenWang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YLBuyStockModel;
@interface YLRevokeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *stockNane;
@property (weak, nonatomic) IBOutlet UILabel *stockPrice;
@property (weak, nonatomic) IBOutlet UILabel *stockNumbers;
@property (weak, nonatomic) IBOutlet UIButton *cellButton;
@property (weak, nonatomic) IBOutlet UILabel *buyOrSell;

@property(nonatomic ,strong)YLBuyStockModel *model;
@end
