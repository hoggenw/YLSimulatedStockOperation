//
//  YLSellOutViewController.m
//  YLSimulatedStockOperation
//
//  Created by 千锋 on 16/2/19.
//  Copyright © 2016年 hoggenWang. All rights reserved.
//

#import "YLSellOutViewController.h"
#import "YLSellOutTableViewCell.h"
#import "YLBuyStockModel.h"
#import "YLSimulatedBuyViewController.h"
@interface YLSellOutViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *dataArray;
}
@property (weak, nonatomic) IBOutlet UITableView *newsTableView;

@end

@implementation YLSellOutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatTableViewShow];
    self.title=@"卖出";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**返回回调*/
-(void)onLeftClicked:(UIButton *)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
/**
 *  tableView视图
 */

-(void)creatTableViewShow{
    
    [_newsTableView registerNib:[UINib nibWithNibName:@"YLSellOutTableViewCell" bundle:nil] forCellReuseIdentifier:@"CELL"];
    _newsTableView.delegate=self;
    _newsTableView.dataSource=self;
    [self requestDataFromDB];
    
}
/**获取数据*/
-(void)requestDataFromDB{
    if (!dataArray) {
        dataArray=[NSMutableArray array];
    }else{
        [dataArray removeAllObjects];
    }
    dataArray= [NSMutableArray arrayWithArray:[self choiceStocksCanBeSellOUT:[NSMutableArray arrayWithArray:[[YLDataManager shareManager]selectAllTradesStocks]]]];
    
}
/**选着能够被卖出的股票*/
-(NSArray *)choiceStocksCanBeSellOUT:(NSArray *)array{
    NSMutableArray *needArray=[NSMutableArray array];
    NSDate *nowDate=[NSDate date];
    NSString *selectString=[nowDate formattedDateWithFormat:@"YYYY/MM/dd HH:mm:ss"];
    NSArray *nowArray=[selectString componentsSeparatedByString:@" "];
    NSString *needString1=[nowArray firstObject];
    for (YLBuyStockModel *temp in array) {
        NSString *select=[temp.mainKey formattedDateWithFormat:@"YYYY/MM/dd HH:mm:ss"];
        NSArray  *modelArray=[select componentsSeparatedByString:@" "];
        NSString *need2String=[modelArray firstObject];
        if ([need2String isEqualToString:needString1]) {
            [needArray addObject:temp];
        }
    }
    return needArray;
}
/**
 *  tableView回调
 */
//组中单元格数组
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YLSellOutTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if (!cell) {
        cell=[[YLSellOutTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CELL"];
    }
    cell.model=dataArray[indexPath.row];
    [cell.sellButton addTarget:self action:@selector(cellButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(void)cellButtonAction:(UIButton*)sender{
    
    YLSellOutTableViewCell * cell = (YLSellOutTableViewCell *)[[sender superview] superview];
    YLSimulatedBuyViewController *simVC=[[YLSimulatedBuyViewController alloc]init];
    simVC.stockNumber=cell.model.stockNumber;
    simVC.price=cell.model.buyPrice;
    simVC.ifSell=YES;
    simVC.selfTitle=cell.model.stockName;
    simVC.stockBuyNumber=cell.model.buyNumber;
    cell.model.ifSell=YES;
    simVC.SELLModel=cell.model;
    [self.navigationController pushViewController:simVC animated:YES];
   
    
}
@end
