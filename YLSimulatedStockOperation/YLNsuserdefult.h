//
//  YLNsuserdefult.h
//  YLSimulatedStockOperation
//
//  Created by 千锋 on 16/2/17.
//  Copyright © 2016年 hoggenWang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YLNsuserdefult : NSObject{
        BOOL isExist;
    
}
/**
 *  存储自选股
 */
+(void)saveSelfChioceStock:(NSString *)stock forKey:(NSString *)keyString;
/**
*  取出所有自选股
*/
+(NSArray *)getSelfStocksForKey:(NSString *)keyString;
/**
 *  判断股票是否存在
 */
+(BOOL )judgeStockIsExist:(NSString *)stockString;
/**
 *  存自选股数组
 */
+(void)saveSelfStocks:(NSArray*)stock forKey:(NSString *)keyString;
@end
