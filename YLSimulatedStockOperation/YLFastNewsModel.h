//
//  YLFastNewsModel.h
//  YLSimulatedStockOperation
//
//  Created by Waterstrong on 2/11/16.
//  Copyright © 2016 hoggenWang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YLFastNewsModel : NSObject
/**大概内容*/
@property (nonatomic, copy) NSString *n_Abstract;
/**http://m.emoney.cn/html/news/9d/9d4da052-b8b3-4a29-b166-9ddabcde431c.html网站*/
@property (nonatomic, copy) NSString *n_id;
/**这个无用*/
@property (nonatomic, copy) NSString *n_id_id;
/**标题*/
@property (nonatomic, copy) NSString *n_title;
/**时间*/
@property (nonatomic, copy) NSString *date;

@end
