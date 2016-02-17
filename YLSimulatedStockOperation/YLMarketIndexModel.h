//
//  YLMarketIndexModel.h
//  YLSimulatedStockOperation
//
//  Created by Waterstrong on 2/14/16.
//  Copyright © 2016 hoggenWang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YLMarketIndexModel : NSObject
/**题目*/
@property (nonatomic, copy) NSString *marketName;
/**大盘点数*/
@property (nonatomic, copy) NSString *marketCount;
/**变化点数*/
@property (nonatomic, copy) NSString *marketChange;
/**变化百分比*/
@property (nonatomic, copy) NSString *changePercent;
/**股票代码*/
@property(nonatomic,copy)NSString *stockNumber;

@end
