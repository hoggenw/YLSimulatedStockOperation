//
//  YLTheFastNew.h
//  YLSimulatedStockOperation
//
//  Created by Waterstrong on 2/11/16.
//  Copyright © 2016 hoggenWang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YLFastNewsModel;
/*最新咨询的数据获取与处理*/
@interface YLTheFastNew : NSObject

/**请求数据*/
-(NSArray*)requestDataTheFastNews;
@end
