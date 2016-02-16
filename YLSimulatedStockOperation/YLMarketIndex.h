//
//  YLMarketIndex.h
//  YLSimulatedStockOperation
//
//  Created by Waterstrong on 2/14/16.
//  Copyright © 2016 hoggenWang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YLMarketIndexModel;
@interface YLMarketIndex : NSObject
@property(nonatomic,copy) void(^needModel)(YLMarketIndexModel*);
/**
 *  获取大盘数据
 */
-(void)requestDataFromNet:(NSString *)urlString;
/**
 *  获取个股数据
 */
-(void)requestStockDataFromNet:(NSString *)urlString;
@end
