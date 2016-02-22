//
//  YLBuyStockModel.h
//  YLSimulatedStockOperation
//
//  Created by 千锋 on 16/2/18.
//  Copyright © 2016年 hoggenWang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YLBuyStockModel : NSObject
@property(nonatomic,strong)NSDate *mainKey;
@property(nonatomic,copy)NSString *stockName;
@property(nonatomic,copy)NSString *stockNumber;
@property(nonatomic,copy)NSString *buyPrice;
@property(nonatomic,copy)NSString *buyNumber;
@property(nonatomic,assign)BOOL  ifTrade;
@property(nonatomic,assign)BOOL  ifSell;

@end
