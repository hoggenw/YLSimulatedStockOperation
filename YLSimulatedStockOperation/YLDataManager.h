//
//  YLDataManager.h
//  YLSimulatedStockOperation
//
//  Created by 千锋 on 16/2/18.
//  Copyright © 2016年 hoggenWang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class  YLBuyStockModel;
@interface YLDataManager : NSObject
+(instancetype)shareManager;
/**
 *  获取所有买入数据
 */
-(NSArray *)selectAllBuyStockData;
/**
 *  删除买入数据
 */
-(BOOL)deleteBuyStockData:(YLBuyStockModel *)model;
/**
 *  添加买入数据
 */
-(BOOL)insertBuyStockData:(YLBuyStockModel *)model;
/**
 *  获取所有未成交的数据
 */
-(NSArray*)selectAllNotTradeStocks;
/**
 *  获取所有成交数据
 */
-(NSArray *)selectAllTradesStocks;



/**
 *  删除卖出入数据
 */
-(BOOL)deleteSELLStockData:(YLBuyStockModel *)model;
/**
 *  添加卖出数据
 */
-(BOOL)insertSELLStockData:(YLBuyStockModel *)model;
/**
 *  获取所有卖出未成交的数据
 */
-(NSArray*)selectAllSellNotTradeStocks;

@end

