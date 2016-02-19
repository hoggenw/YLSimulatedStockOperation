//
//  YLDataManager.m
//  YLSimulatedStockOperation
//
//  Created by 千锋 on 16/2/18.
//  Copyright © 2016年 hoggenWang. All rights reserved.
//

#import "YLDataManager.h"
#import "YLBuyStockModel.h"
@implementation YLDataManager{
    FMDatabase *fmdb;
}
-(instancetype)init{
    @throw [NSException exceptionWithName:@"" reason:@"不能用此方法构造" userInfo:nil];
}
-(instancetype)initPrivate{
    if (self=[super init]) {
        [self creatDataBase];
    }
    return self;
}
+(instancetype)shareManager{
    static YLDataManager *manager=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!manager) {
            manager=[[self alloc]initPrivate];
        }
    });
    return manager;
}
-(void)creatDataBase{
    NSArray *docunmensPath=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *dbPath=[[docunmensPath firstObject] stringByAppendingPathComponent:@"BuyStockDataBasse.db"];
   // NSLog(@"%@",dbPath);
    if (!fmdb) {
        fmdb=[[FMDatabase alloc]initWithPath:dbPath];
    }
    if ([fmdb open]) {
        [fmdb executeUpdate:@"create table if not exists BUYSTOCKTabel(mainkey date primary key,stockName not null,stockNumber not null, buyPrice not null,buyNumber not null,ifTrade not null);"];
    }
}
/**
 *  添加买入数据
 */
-(BOOL)insertBuyStockData:(YLBuyStockModel *)model{
    BOOL success=[fmdb executeUpdate:@"insert into BUYSTOCKTabel values(?,?,?,?,?,?)",model.mainKey,model.stockName,model.stockNumber,model.buyPrice,model.buyNumber,@(model.ifTrade)];
    return success;
}
/**
 *  删除买入数据
 */
-(BOOL)deleteBuyStockData:(YLBuyStockModel *)model{
    BOOL success=[fmdb executeUpdate:@"delete from BUYSTOCKTabel where mainkey=?",model.mainKey];
    return success;
}

/**
 *  获取所有买入数据
 */
-(NSArray *)selectAllBuyStockData{
    FMResultSet *rs=[fmdb executeQuery:@"select * from BUYSTOCKTabel"];
    NSMutableArray *models=[NSMutableArray array];
    while ([rs next]) {
        YLBuyStockModel *model=[[YLBuyStockModel alloc]init];
        model.mainKey =[rs dateForColumn: @"mainKey"];
        model.stockName=[rs stringForColumn:@"stockName"];
        model.stockNumber=[rs stringForColumn:@"stockNumber"];
        model.buyPrice=[rs stringForColumn:@"buyPrice"];
        model.buyNumber=[rs stringForColumn:@"buyNumber"];
        model.ifTrade=[rs boolForColumn:@"ifTrade"];
        [models addObject:model];
    }
    return models;
}



@end

















