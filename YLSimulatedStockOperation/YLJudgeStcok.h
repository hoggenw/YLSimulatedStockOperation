//
//  YLJudgeStcok.h
//  YLSimulatedStockOperation
//
//  Created by 千锋 on 16/2/15.
//  Copyright © 2016年 hoggenWang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YLJudgeStcok : NSObject
/**
 *  判断是哪个市场的股票，并且处理成合适的字符串
 */
+(NSString *)judgeStockAndDeal:(NSString *)stringStock;
@end
