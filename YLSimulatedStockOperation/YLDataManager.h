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
@end
