//
//  YLSelfStcocksViewController.m
//  YLSimulatedStockOperation
//
//  Created by 千锋 on 16/2/17.
//  Copyright © 2016年 hoggenWang. All rights reserved.
//

#import "YLSelfStcocksViewController.h"
#import "YLMarketIndex.h"
#import "YLMarketIndexModel.h"
#import "YLjUSTStockTableViewCell.h"
#import "YLSIghnStockMessageViewController.h"
@interface YLSelfStcocksViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *dataArray;
    NSTimer *timer;
}
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@end

@implementation YLSelfStcocksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatTableViewShow];
    self.title=@"我的自选股";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)creatTableViewShow{
    [_myTableView registerNib:[UINib nibWithNibName:@"YLjUSTStockTableViewCell" bundle:nil] forCellReuseIdentifier:@"CELL"];
    _myTableView.delegate=self;
    _myTableView.dataSource=self;
    [MBProgressHUD showHUDAddedTo:_myTableView animated:YES];
    timer=[NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(loadData) userInfo:nil repeats:YES];
   
   
}
/**加载数据*/
-(void)loadData{
    if (!dataArray) {
        dataArray=[NSMutableArray array];
    }else{
        dataArray=nil;
        dataArray=[NSMutableArray array];
    }
    
     NSArray *array=[NSArray arrayWithArray:[YLNsuserdefult getSelfStocksForKey:@"selfStocks"]];
    if (array.count==0) {
       [MBProgressHUD hideAllHUDsForView:_myTableView animated:YES]; 
    }
     __weak typeof(self) weakSelf=self;
    for (int index=0; index<array.count; index++) {
        YLMarketIndex *newGet=[[YLMarketIndex alloc]init];
        newGet.needModel=^(YLMarketIndexModel *model){
            [dataArray addObject:model];
            dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf.myTableView  reloadData];
                [MBProgressHUD hideAllHUDsForView:_myTableView animated:YES];
            });
            
        };
        NSString *urlString=[NSString stringWithFormat:@"http://hq.sinajs.cn/list=s_%@",array[index]];
        [newGet requestStockDataFromNet:urlString];
    }
   
}
/**
 *  tableView回调
 */
//组中单元格数组
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YLjUSTStockTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if (!cell) {
        cell=[[YLjUSTStockTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CELL"];
    }
    cell.model=dataArray[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    YLSIghnStockMessageViewController *signDogVc=[[YLSIghnStockMessageViewController alloc]init];
    YLMarketIndexModel *model=dataArray[indexPath.row];
    signDogVc.stockNumber=model.stockNumber;
    [self.navigationController pushViewController:signDogVc animated:YES];
    
}
-(void)dealloc{
    if (timer) {
        [timer invalidate];
        timer=nil;
    }
}
@end
