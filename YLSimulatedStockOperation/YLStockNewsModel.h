//
//  YLStockNewsModel.h
//  YLSimulatedStockOperation
//
//  Created by Waterstrong on 2/11/16.
//  Copyright © 2016 hoggenWang. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  股票新闻model
 */
@interface YLStockNewsModel : NSObject

@property (nonatomic, copy) NSString *ref;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, copy) NSString *date;


@end
