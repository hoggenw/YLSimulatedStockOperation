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
/**
 *  获取大盘数据
 */
+(YLMarketIndexModel *)requestDataFromNet:(NSString *)urlString;
@end
