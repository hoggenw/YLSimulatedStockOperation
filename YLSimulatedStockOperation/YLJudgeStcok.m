//
//  YLJudgeStcok.m
//  YLSimulatedStockOperation
//
//  Created by 千锋 on 16/2/15.
//  Copyright © 2016年 hoggenWang. All rights reserved.
//

#import "YLJudgeStcok.h"

@implementation YLJudgeStcok
/**
 *  判断是哪个市场的股票，并且处理成合适的字符串
 */
+(NSString *)judgeStockAndDeal:(NSString *)stringStock{
    if ( [stringStock rangeOfString: @"sz"].length!=0 ) {
        return stringStock;
    }else if ([stringStock rangeOfString:@"sh" ].length!=0){
        return stringStock;
    }else if([[stringStock substringToIndex:1] isEqualToString:@"0"]||[[stringStock substringToIndex:1] isEqualToString:@"3"]){
        return [NSString stringWithFormat:@"sz%@",stringStock];
    }else if ([[stringStock substringToIndex:1] isEqualToString:@"6"]){
        return [NSString stringWithFormat:@"sh%@",stringStock];
    }
    return nil;
}
@end
