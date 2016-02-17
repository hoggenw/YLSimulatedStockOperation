//
//  YLNsuserdefult.m
//  YLSimulatedStockOperation
//
//  Created by 千锋 on 16/2/17.
//  Copyright © 2016年 hoggenWang. All rights reserved.
//

#import "YLNsuserdefult.h"

@implementation YLNsuserdefult
/**
 *  存储自选股
 */
+(void)saveSelfChioceStock:(NSString *)stock forKey:(NSString *)keyString{
    NSUserDefaults *userDef=[NSUserDefaults standardUserDefaults];
    NSArray *array=[userDef arrayForKey:keyString];
    NSMutableArray *selfArray=[NSMutableArray arrayWithArray:array];
    //将用户默认设置保存以键值对方式保存
    [selfArray addObject:stock];
    [userDef setObject:selfArray  forKey:keyString];
    //同步（立即保存键值对）防止程序应意外崩溃，导致数据没有来得及保存
    [userDef synchronize];
}
/**
 *  判断股票是否存在
 */
+(BOOL )judgeStockIsExist:(NSString *)stockString{
    NSUserDefaults *userDef=[NSUserDefaults standardUserDefaults];
    NSArray *array=[userDef arrayForKey:@"selfStocks"];
    for (NSString *temp in array) {
        if ([temp isEqualToString:stockString]) {
            return YES;
        }
    }
    return NO;
}
/**
 *  取出所有自选股
 */
+(NSArray *)getSelfStocksForKey:(NSString *)keyString{
    NSUserDefaults *userDef=[NSUserDefaults standardUserDefaults];
    return [userDef arrayForKey:keyString];
}
/**
 *  存自选股数组
 */
+(void)saveSelfStocks:(NSArray*)stock forKey:(NSString *)keyString{
    NSUserDefaults *userDef=[NSUserDefaults standardUserDefaults];
    [userDef setObject:stock  forKey:keyString];
    [userDef synchronize];
}
@end
