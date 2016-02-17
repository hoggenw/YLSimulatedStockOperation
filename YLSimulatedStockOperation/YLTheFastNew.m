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
#import "YLStockNoticesModel.h"

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
/**
 *  请求股票公告
 */
-(void)requestStockNotice:(NSString *)urlString{
    NSMutableArray *dataArray=[NSMutableArray array];
    NSString  *needString=[urlString substringFromIndex:2];
    NSURLSession *mySession=[NSURLSession sharedSession];
    NSURLSessionDataTask *myTask=[mySession dataTaskWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://sjhq.itougu.jrj.com.cn/info/noticelist/%@?count=10&page=0",needString]] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSArray *dataNeedArray=dict[@"notice"];
            for (NSDictionary *temp in dataNeedArray) {
                YLStockNoticesModel *newModel=[[YLStockNoticesModel alloc]init];
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
 *  请求股票资金数据
 */
-(void)requestStockCrashData:(NSString *)urlString{
    NSURLSession *mySession=[NSURLSession sharedSession];
    NSURLSessionDataTask *myTask=[mySession dataTaskWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://qt.gtimg.cn/q=ff_%@",urlString]] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            NSStringEncoding gbkEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
            //使用如下方法 将获取到的数据按照gbkEncoding的方式进行编码，结果将是正常的汉字
            
            NSString *dict =[[NSString alloc]initWithData:data encoding:gbkEncoding];
            
            NSArray *array=[dict componentsSeparatedByString:@"~"];
            if (_needArray) {
                _needArray(array);
                
            }
        }else{
            
        }
    }];
    [myTask resume];
}
/**
 *  请求股票盘口数据
 */
-(void)requestStockJudegeDatas:(NSString *)urlsting{
    NSURLSession *mySession=[NSURLSession sharedSession];
    NSURLSessionDataTask *myTask=[mySession dataTaskWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://qt.gtimg.cn/q=s_pk%@",urlsting]] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            NSStringEncoding gbkEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
            //使用如下方法 将获取到的数据按照gbkEncoding的方式进行编码，结果将是正常的汉字
            
            NSString *dict =[[NSString alloc]initWithData:data encoding:gbkEncoding];
            
            NSArray *array=[dict componentsSeparatedByString:@"\""];
            if (array.count>=2) {
                NSString *string=array[1];
                NSArray *needArray=[string componentsSeparatedByString:@"~"];
                if (_needArray) {
                    _needArray(needArray);
                    
                }
            }else{
                if (_needArray) {
                    _needArray(nil);
                    
                }
            }
          
        }else{
            
        }
    }];
    [myTask resume];
}
/**
 *  请求评价数据
 */
-(void)requestJudgeStock:(NSString *)urlString{
    NSMutableArray *dataArray=[NSMutableArray array];
    NSString  *needString=[urlString substringFromIndex:2];
    NSURLSession *mySession=[NSURLSession sharedSession];
    NSURLSessionDataTask *myTask=[mySession dataTaskWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://m.emoney.cn/sosoSD2/Handlers/Stockdiag.ashx?load=stock&symbol=%@",needString]] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
           NSString *firstString=dict[@"pj"];
            NSString *sting=dict[@"rd"];
            NSString *secondString=dict[@"d"];
            [dataArray addObject:[NSString stringWithFormat:@"%@%@",firstString,sting]];
            [dataArray addObject:secondString];
            if (_needArray) {
                _needArray(dataArray);
                
            }
        }else{
            
        }
    }];
    [myTask resume];
}
@end
