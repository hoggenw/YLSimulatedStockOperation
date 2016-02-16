//
//  YLTheFastNew.m
//  YLSimulatedStockOperation
//
//  Created by 千锋 on 16/2/15.
//  Copyright © 2016年 hoggenWang. All rights reserved.
//

#import "YLTheFastNew.h"
#import "YLFastNewsModel.h"
#import "YLStockNewsModel.h"
@implementation YLTheFastNew
/**
 *  请求新闻数据
 */
-(void)requestDataTheFastNews{
    
    NSMutableArray *dataArray=[NSMutableArray array];
    NSURLSession *mySession=[NSURLSession sharedSession];
    NSURLSessionDataTask *myTask=[mySession dataTaskWithURL:[NSURL URLWithString:@"http://t.emoney.cn/2pt/zx/GetCaiJing?fm=0&pp=2&pv=&us=&st=&ld=0&lt=&rg=&se=1122791326&ar=10&mv=7.1.1&vd=959&mt=Xiaomi%2BMI%2B4LTE&pr=&username=865931023645112&ac=20160127&ll=+&lts=0&ep=20160227"] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSArray *dataNeedArray=dict[@"o3"];
            for (NSDictionary *temp in dataNeedArray) {
                YLFastNewsModel *newModel=[[YLFastNewsModel alloc]init];
                [newModel setValuesForKeysWithDictionary:temp];
                [dataArray addObject:newModel];
            }
            if (_needArray) {
                _needArray(dataArray);
                
            }
        }else{
          
        }
    }];
    [myTask resume];
}
/**
 *  请求股票新闻
 */
-(void)requestStockNews:(NSString *)urlString{
    NSMutableArray *dataArray=[NSMutableArray array];
    NSString  *needString=[urlString substringFromIndex:2];
    NSURLSession *mySession=[NSURLSession sharedSession];
    NSURLSessionDataTask *myTask=[mySession dataTaskWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://sjhq.itougu.jrj.com.cn/info/newslist/%@?count=10&page=0",needString]] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSArray *dataNeedArray=dict[@"news"];
            for (NSDictionary *temp in dataNeedArray) {
                YLStockNewsModel *newModel=[[YLStockNewsModel alloc]init];
                [newModel setValuesForKeysWithDictionary:temp];
                [dataArray addObject:newModel];
            }
            if (_needArray) {
                _needArray(dataArray);
                
            }
        }else{
            
        }
    }];
    [myTask resume];
}
@end
