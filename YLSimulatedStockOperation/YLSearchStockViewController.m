//
//  YLSearchStockViewController.m
//  YLSimulatedStockOperation
//
//  Created by 千锋 on 16/2/16.
//  Copyright © 2016年 hoggenWang. All rights reserved.
//

#import "YLSearchStockViewController.h"
#import "YLMarketIndex.h"
#import "YLMarketIndexModel.h"
#import "YLShowStcokTableViewCell.h"
#import "YLSIghnStockMessageViewController.h"
@interface YLSearchStockViewController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *dataArray;
    NSMutableString *searchStockString;
    BOOL isSave;
    NSString *stocknumber;
    BOOL isExist;
}
@property (weak, nonatomic) IBOutlet UISearchBar *stcokSeachBar;
@property (weak, nonatomic) IBOutlet UITableView *mySearchTabelView;

@end

@implementation YLSearchStockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"个股查询";
    [self setSearchBar];
     [self creatTableViewShow];
   
 
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 *  tableView视图
 */

-(void)creatTableViewShow{
  
    [_mySearchTabelView registerNib:[UINib nibWithNibName:@"YLShowStcokTableViewCell" bundle:nil] forCellReuseIdentifier:@"CELL"];
    _mySearchTabelView .delegate=self;
    _mySearchTabelView .dataSource=self;
 
}
/**
 *  tableView回调
 */
//组中单元格数组
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YLShowStcokTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if (!cell) {
        cell=[[YLShowStcokTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CELL"];
    }
    cell.model=dataArray[indexPath.row];
    if ([YLNsuserdefult judgeStockIsExist:searchStockString]) {
        [cell.saveButton setBackgroundImage:[UIImage imageNamed:@"stock_deleta@3x"] forState:UIControlStateNormal];
        isSave=YES;
    }else{
        [cell.saveButton setBackgroundImage:[UIImage imageNamed:@"mockstock_addred"] forState:UIControlStateNormal];
        isSave=NO;
    }
    [cell.saveButton addTarget:self action:@selector(saveButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
/**cell的回调方法*/
-(void)saveButtonAction:(UIButton *)sender{
    if (isSave) {
        [sender setBackgroundImage:[UIImage imageNamed:@"mockstock_addred"] forState:UIControlStateNormal];
        isSave=NO;
        if ([YLNsuserdefult judgeStockIsExist:searchStockString]) {
            NSArray *array=[YLNsuserdefult getSelfStocksForKey:@"selfStocks"];
            NSMutableArray *nowArray=[NSMutableArray arrayWithArray:array];
            [nowArray removeObject:searchStockString];
            [YLNsuserdefult saveSelfStocks:nowArray forKey:@"selfStocks"];
        }
        YLHintView *hView=[[YLHintView alloc]initWithFrame:CGRectMake(0, 0,150, 120)];
        hView.center=self.view.center;
        [self.view addSubview:hView];
        hView.message=@"已从自选股删除";
        [hView showOnView:self.view ForTimeInterval:1.2];
    }else{
        if (![YLNsuserdefult judgeStockIsExist:searchStockString]) {
            [YLNsuserdefult saveSelfChioceStock:searchStockString forKey:@"selfStocks"];
        }
        [sender setBackgroundImage:[UIImage imageNamed:@"stock_deleta@3x"] forState:UIControlStateNormal];
        isSave=YES;
        YLHintView *hView=[[YLHintView alloc]initWithFrame:CGRectMake(0, 0,150, 120)];
        hView.center=self.view.center;
        [self.view addSubview:hView];
        hView.message=@"已加入自选股";
        [hView showOnView:self.view ForTimeInterval:1.2];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    YLSIghnStockMessageViewController *detailNewVC=[[YLSIghnStockMessageViewController alloc]init];
    detailNewVC.stockNumber=searchStockString;
    [self.navigationController pushViewController:detailNewVC animated:YES];
    
}
-(void)setSearchBar{
    [_stcokSeachBar setPlaceholder:@"请输入A股股票代码"];// 搜索框的占位符
    [_stcokSeachBar setShowsSearchResultsButton:YES];// 是否显示搜索结果按钮
    [_stcokSeachBar setKeyboardType:UIKeyboardTypeNumberPad];// 设置键盘样式

    [_stcokSeachBar setShowsBookmarkButton:YES];// 是否显示右侧的“书图标”
    _stcokSeachBar.delegate = self;// 设置代理
}
- (IBAction)sureSearch:(UIButton *)sender {
    if (!dataArray) {
        dataArray=[NSMutableArray array];
    }else{
        dataArray=nil;
        dataArray=[NSMutableArray array];
    }
    if (_stcokSeachBar.text.length==6) {
          __weak typeof(self) weakSelf=self;
     searchStockString=[NSMutableString stringWithString:[YLJudgeStcok judgeStockAndDeal:[NSMutableString stringWithString:_stcokSeachBar.text]]];
        YLMarketIndex *newGet=[[YLMarketIndex alloc]init];
        newGet.needModel=^(YLMarketIndexModel *model){
            [dataArray addObject:model];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (model.marketName.length==0) {
                    YLHintView *hView=[[YLHintView alloc]initWithFrame:CGRectMake(0, 0,150, 120)];
                    hView.center=self.view.center;
                    [self.view addSubview:hView];
                    hView.message=@"无该股票信息";
                    [hView showOnView:self.view ForTimeInterval:1.2];
                     [MBProgressHUD hideAllHUDsForView:_mySearchTabelView  animated:YES];
                }else{
                
                [weakSelf.mySearchTabelView  reloadData];
                [MBProgressHUD hideAllHUDsForView:_mySearchTabelView  animated:YES];
                }
            });
            
        };
        NSString *urlString=[NSString stringWithFormat:@"http://hq.sinajs.cn/list=s_%@",searchStockString];
        [newGet requestStockDataFromNet:urlString];
        [MBProgressHUD showHUDAddedTo:_mySearchTabelView animated:YES];
    }else{
        YLHintView *hView=[[YLHintView alloc]initWithFrame:CGRectMake(0, 0,150, 120)];
        hView.center=self.view.center;
        [self.view addSubview:hView];
        hView.message=@"股票代码不符合规范";
        [hView showOnView:self.view ForTimeInterval:1.2];
    }
  
}
-(void)viewWillAppear:(BOOL)animated{
     dispatch_async(dispatch_get_main_queue(), ^{
    [_mySearchTabelView reloadData];
     });
}

@end
