//
//  YLSimulatedStockViewController.m
//  YLSimulatedStockOperation
//
//  Created by Waterstrong on 2/13/16.
//  Copyright © 2016 hoggenWang. All rights reserved.
//

#import "YLSimulatedStockViewController.h"
#import "YLDealStockTableViewCell.h"
#import "YLSIghnStockMessageViewController.h"
#import "YLBuyStockModel.h"
#import "YLMarketIndex.h"
#import "YLMarketIndexModel.h"
#import "YLSearchStockViewController.h"
#import "YLArrayModel.h"
#import "YLRevokTradeViewController.h"
#import "YLSellOutViewController.h"
@interface YLSimulatedStockViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *dataArray;
    YLArrayModel *arrayModel;
    NSString *stockValueSting;
    NSString *totalMoneyString;
    NSString *totalPercentString;
    NSInteger mytotalMoney;
    NSInteger arrayCount;
  
}
/**
 *  总收益率
 */
@property (weak, nonatomic) IBOutlet UILabel *totalGetPercent;
/**总资产*/
@property (weak, nonatomic) IBOutlet UILabel *totalMoney;
/**可用资金*/
@property (weak, nonatomic) IBOutlet UILabel *canUseMoney;
/**股票市值*/
@property (weak, nonatomic) IBOutlet UILabel *stockValue;
/**显示交易信息的tableView*/
@property (weak, nonatomic) IBOutlet UITableView *showBuyStocks;

@end

@implementation YLSimulatedStockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    arrayModel=[[YLArrayModel alloc]init];
   
    [self creatTabelView];
    self.title=@"模拟炒股";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**买入视图*/
- (IBAction)buyInButtonAction:(UIButton *)sender {
    YLSearchStockViewController *searchVC=[[YLSearchStockViewController alloc]init];
    [self.navigationController pushViewController:searchVC animated:YES];
}
/**撤单视图*/
- (IBAction)revokeTrade:(UIButton *)sender {
    YLRevokTradeViewController *revokeVC=[[YLRevokTradeViewController alloc]init];
    [self.navigationController pushViewController:revokeVC animated:YES];
}
/**卖出视图*/
- (IBAction)sellOutButton:(UIButton *)sender {
    YLSellOutViewController *sellVC=[[YLSellOutViewController alloc]init];
    [self.navigationController pushViewController:sellVC animated:YES];
}

/**
 *  更新视图
 */
-(void)updateViewFoo{
    if (arrayModel.buyStocksArray) {
        arrayModel.buyStocksArray=nil;
        arrayModel.buyStocksArray=[NSMutableArray array];
    }else{
        arrayModel.buyStocksArray=[NSMutableArray array];
    }
    arrayCount=0;
    stockValueSting=[NSString string];
    totalMoneyString=[NSString string];
    totalPercentString=[NSString string];
    NSArray *buyArray=[[YLDataManager shareManager] selectAllBuyStockData];
    mytotalMoney=[YLNsuserdefult getMoneyUserForKey:@"Smoney"];
    if (buyArray.count==0) {
        stockValueSting=@"0";
        totalMoneyString=[NSString stringWithFormat:@"%ld",mytotalMoney];
        CGFloat foo=([totalMoneyString doubleValue]-100000)/100000;
        totalPercentString=[NSString stringWithFormat:@"%.2lf%%",foo];
        dispatch_async(dispatch_get_main_queue(), ^{
            _totalGetPercent.text=totalPercentString;
            _totalMoney.text=totalMoneyString;
            _stockValue.text=stockValueSting;
        });
       
    }else{
         [self hintMessage];
         [arrayModel addObserver:self forKeyPath:NSStringFromSelector(@selector(buyStocksArray)) options:NSKeyValueObservingOptionNew context:nil];
        for (int index=0; index<buyArray.count; index++) {
            YLBuyStockModel *model=[[YLBuyStockModel alloc]init];
            model=buyArray[index];
            YLMarketIndex *newGet=[[YLMarketIndex alloc]init];
            newGet.needModel=^(YLMarketIndexModel *model){
                [[arrayModel mutableArrayValueForKey:@"buyStocksArray"] addObject:model];
            };
            NSString *urlString=[NSString stringWithFormat:@"http://hq.sinajs.cn/list=s_%@",[YLJudgeStcok judgeStockAndDeal:model.stockNumber]];
            [newGet requestStockDataFromNet:urlString];
        }
            [arrayModel addObserver:self forKeyPath:NSStringFromSelector(@selector(buyStocksArray)) options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        _canUseMoney.text=[NSString stringWithFormat:@"%.0ld",mytotalMoney];
    });
    

    
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(buyStocksArray))]) {
        CGFloat stocksTotalMoney=0;
        NSArray *array=[[YLDataManager shareManager] selectAllBuyStockData];
        if (arrayModel.buyStocksArray.count==array.count) {
            for (int index=0; index<array.count; index++) {
                YLBuyStockModel *buyModel=[[YLBuyStockModel alloc]init];
                buyModel=array[index];
                for (YLMarketIndexModel *model in arrayModel.buyStocksArray) {
                    if ([model.marketName isEqualToString:buyModel.stockName]) {
                        if(buyModel.ifTrade){
                        CGFloat addMoney=[model.marketCount doubleValue]*[buyModel.buyNumber doubleValue];
                        stocksTotalMoney+=addMoney;
                        break;
                        }else{
                            CGFloat addMoney=[buyModel.buyPrice doubleValue]*[buyModel.buyNumber doubleValue];
                        stocksTotalMoney+=addMoney;
                            break;
                        }
                    }
                }
            }
            stockValueSting=[NSString stringWithFormat:@"%.0lf",stocksTotalMoney];
             mytotalMoney=[YLNsuserdefult getMoneyUserForKey:@"Smoney"];
            totalMoneyString=[NSString stringWithFormat:@"%.1lf",(stocksTotalMoney+mytotalMoney)];
            CGFloat foo=([totalMoneyString doubleValue]-100000)/100000;
            totalPercentString=[NSString stringWithFormat:@"%.2lf%%",foo*100];
            dispatch_async(dispatch_get_main_queue(), ^{
                _totalGetPercent.text=totalPercentString;
                _totalMoney.text=totalMoneyString;
                _stockValue.text=stockValueSting;
            });
          [object removeObserver:self forKeyPath:NSStringFromSelector(@selector(buyStocksArray))];
        }
    }
    
}
-(void)creatTabelView{
    UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 210, self.view.bounds.size.width, self.view.bounds.size.height-210)];
    if ([[YLDataManager shareManager] selectAllBuyStockData].count==0) {
        
        imageview.image=[UIImage imageNamed:@"haveNotBuy"];
        [self.view addSubview:imageview];
    }else{
    [imageview removeFromSuperview];
    [_showBuyStocks registerNib:[UINib nibWithNibName:@"YLDealStockTableViewCell" bundle:nil] forCellReuseIdentifier:@"CELL"];
    _showBuyStocks.delegate=self;
    _showBuyStocks.dataSource=self;
        if (!dataArray) {
            dataArray=[NSMutableArray array];
            
        }else{
            dataArray=nil;
             dataArray=[NSMutableArray array];
        }
        dataArray=[NSMutableArray arrayWithArray:[[YLDataManager shareManager] selectAllBuyStockData]];
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
    YLDealStockTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if (!cell) {
        cell=[[YLDealStockTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CELL"];
    }
    cell.model=dataArray[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    YLSIghnStockMessageViewController *detailNewVC=[[YLSIghnStockMessageViewController alloc]init];
    YLBuyStockModel *model=dataArray[indexPath.row];
    detailNewVC.stockNumber=model.stockNumber;
    [self.navigationController pushViewController:detailNewVC animated:YES];
    
}
-(void)dealloc{
   
}
-(void)viewWillAppear:(BOOL)animated{
   
}
-(void)hintMessage{
    YLHintView *hView=[[YLHintView alloc]initWithFrame:CGRectMake(0, 0,150, 120)];
    hView.center=self.view.center;
    [self.view addSubview:hView];
    hView.message=@"如果网络不好或者开盘之前的获得的数据可能不准确，仅供参考";
    [hView showOnView:self.view ForTimeInterval:1.2];
}
-(void)viewDidAppear:(BOOL)animated{
     [self updateViewFoo];
}
@end






















