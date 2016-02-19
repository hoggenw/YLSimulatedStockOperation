//
//  YLMarketIndex.m
//  YLSimulatedStockOperation
//
//  Created by Waterstrong on 2/14/16.
//  Copyright © 2016 hoggenWang. All rights reserved.
//

#import "YLMarketIndex.h"
#import "YLMarketIndexModel.h"
@implementation YLMarketIndex
/**
 *  获取大盘数据
 */
-(void)requestDataFromNet:(NSString *)urlString{
    YLMarketIndexModel *indexModel=[[YLMarketIndexModel alloc]init];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (!error) {
        NSStringEncoding gbkEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        //使用如下方法 将获取到的数据按照gbkEncoding的方式进行编码，结果将是正常的汉字
        
        NSString *dict =[[NSString alloc]initWithData:data encoding:gbkEncoding];
     
        NSArray *array=[dict componentsSeparatedByString:@"\""];
        if (array.count>=2) {
            NSString *useString=array[1];
            
            NSArray *modelArray=[useString componentsSeparatedByString:@","];
            if (modelArray.count>=4) {
                indexModel.marketName=modelArray[0];
                indexModel.marketCount=modelArray[1];
                indexModel.marketChange=modelArray[2];
                indexModel.changePercent=modelArray[3];
            }else{
                
            }
            if (_needModel) {
                _needModel(indexModel);
              
            }
        }else{
            if (_needModel) {
                _needModel(indexModel);
                
            }
        }
        }else{
            if (_needModel) {
                _needModel(indexModel);
                
            }
        }
        
    }];
    [task resume];

}
/**
 *  获取个股数据
 */
-(void)requestStockDataFromNet:(NSString *)urlString{
    YLMarketIndexModel *indexModel=[[YLMarketIndexModel alloc]init];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (!error) {
            NSStringEncoding gbkEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
            //使用如下方法 将获取到的数据按照gbkEncoding的方式进行编码，结果将是正常的汉字
            
            NSString *dict =[[NSString alloc]initWithData:data encoding:gbkEncoding];
            
            NSArray *array=[dict componentsSeparatedByString:@"\""];
            if (array.count>=2) {
                NSString *useString=array[1];
                NSString *stockString=array[0];
                NSArray *stockArray=[stockString componentsSeparatedByString:@"="];
                NSString *stockString1=stockArray[0];
                indexModel.stockNumber=[[stockString1 componentsSeparatedByString:@"_"]lastObject];
                NSArray *modelArray=[useString componentsSeparatedByString:@","];
                if (modelArray.count>=4) {
                    indexModel.marketName=modelArray[0];
                    indexModel.marketCount=modelArray[1];
                    indexModel.marketChange=modelArray[2];
                    indexModel.changePercent=modelArray[3];
                    if (_needModel) {
                        _needModel(indexModel);
                        
                    }
                }else{
                    if (_needModel) {
                        _needModel(indexModel);
                        
                    }
                }
            }else{
                if (_needModel) {
                    _needModel(indexModel);
                    
                }
            }
        }else{
            if (_needModel) {
                _needModel(indexModel);
                
            }
        }
        
    }];
    [task resume];
}
@end
