//
//  YLNewsTableViewCell.h
//  YLSimulatedStockOperation
//
//  Created by 千锋 on 16/2/15.
//  Copyright © 2016年 hoggenWang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YLFastNewsModel;
@interface YLNewsTableViewCell : UITableViewCell
@property(nonatomic ,strong)YLFastNewsModel *model;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabe;
@end
