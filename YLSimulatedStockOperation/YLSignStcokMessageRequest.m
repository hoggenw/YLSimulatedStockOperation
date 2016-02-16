//
//  YLSignStcokMessageRequest.m
//  YLSimulatedStockOperation
//
//  Created by 千锋 on 16/2/15.
//  Copyright © 2016年 hoggenWang. All rights reserved.
//

#import "YLSignStcokMessageRequest.h"

@implementation YLSignStcokMessageRequest
/**
 *  请求股票数据
 */
-(void)requestStockMessage:(NSString *)stockNumber{
    NSString *urlString=[NSString stringWithFormat:@"http://qt.gtimg.cn/q=%@",stockNumber];
    NSURLSession *mySession=[NSURLSession sharedSession];
    NSURLSessionDataTask *myTask=[mySession dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            NSStringEncoding gbkEnconding=CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
            NSString *string=[[NSString alloc]initWithData:data encoding:gbkEnconding];
           NSArray *dataArray=[NSMutableArray arrayWithArray:[string componentsSeparatedByString:@"~"]];
            if (_needArray) {
                _needArray(dataArray);
                
            }
        }else{
            
        }
    }];
    [myTask resume];
}
@end


















