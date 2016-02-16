//
//  YLSignStcokMessageRequest.h
//  YLSimulatedStockOperation
//
//  Created by 千锋 on 16/2/15.
//  Copyright © 2016年 hoggenWang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YLSignStcokMessageRequest : NSObject
@property(nonatomic ,copy)void (^needArray)(NSArray *);
/**
 *  请求股票数据
 */
-(void)requestStockMessage:(NSString *)stockNumber;
@end
