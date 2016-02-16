//
//  YLTheFastNew.h
//  YLSimulatedStockOperation
//
//  Created by 千锋 on 16/2/15.
//  Copyright © 2016年 hoggenWang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YLTheFastNew : NSObject
@property(nonatomic ,copy)void (^needArray)(NSArray *);
/**
 *  请求新闻数据
 */
-(void)requestDataTheFastNews;
/**
 *  请求股票新闻
 */
-(void)requestStockNews:(NSString *)urlString;
@end
