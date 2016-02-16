//
//  YLStockNewsTableViewCell.h
//  YLSimulatedStockOperation
//
//  Created by 千锋 on 16/2/16.
//  Copyright © 2016年 hoggenWang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YLStockNewsModel;
@interface YLStockNewsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *newsTitle;
@property (weak, nonatomic) IBOutlet UILabel *dateString;
@property(nonatomic,strong)YLStockNewsModel *model;
@end
