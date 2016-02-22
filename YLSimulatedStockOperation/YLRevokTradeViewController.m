//
//  YLRevokTradeViewController.m
//  YLSimulatedStockOperation
//
//  Created by 千锋 on 16/2/19.
//  Copyright © 2016年 hoggenWang. All rights reserved.
//

#import "YLRevokTradeViewController.h"
#import "YLRevokeTableViewCell.h"
#import "YLBuyStockModel.h"
@interface YLRevokTradeViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *dataArray;
    YLBuyStockModel *deleteModel;
}
@property (weak, nonatomic) IBOutlet UITableView *newsTableView;

@end

@implementation YLRevokTradeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"撤单";
    [self creatTableViewShow];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 *  tableView视图
 */

-(void)creatTableViewShow{
    
    [_newsTableView registerNib:[UINib nibWithNibName:@"YLRevokeTableViewCell" bundle:nil] forCellReuseIdentifier:@"CELL"];
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
    NSMutableArray *arraybong=[NSMutableArray array];
    arraybong=[NSMutableArray arrayWithArray:[[YLDataManager shareManager] selectAllBuyStockData]];
    dataArray=[NSMutableArray arrayWithArray:[[YLDataManager shareManager] selectAllSellNotTradeStocks]];
    for (YLBuyStockModel *temp in arraybong) {
        [dataArray addObject:temp];
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
    YLRevokeTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if (!cell) {
        cell=[[YLRevokeTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CELL"];
    }
    cell.model=dataArray[indexPath.row];
    [cell.cellButton addTarget:self action:@selector(cellButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
/**删除按钮点击*/
-(void)cellButtonAction:(UIButton*)sender{

    YLRevokeTableViewCell * cell = (YLRevokeTableViewCell *)[[sender superview] superview];
    NSInteger money=[YLNsuserdefult getMoneyUserForKey:@"Smoney"];
    if ([[YLDataManager shareManager]deleteBuyStockData:cell.model]) {
        YLHintView *hView=[[YLHintView alloc]initWithFrame:CGRectMake(0, 0,150, 120)];
        hView.center=self.view.center;
        [self.view addSubview:hView];
        hView.message=@"撤销成功";
        [hView showOnView:self.view ForTimeInterval:1.2];
        CGFloat addMoney=[cell.model.buyPrice doubleValue]*[cell.model.buyNumber doubleValue];
        money+=(NSInteger)addMoney;
        [YLNsuserdefult saveMoney:money UserForKey:@"Smoney"];
        [self customTabBarButtonTitle:@"返回" image:nil target:self action:@selector(onLeftClicked:)  isLeft:YES];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self requestDataFromDB];
        [_newsTableView reloadData];
    });
    
}
/**
 *  设置左边项
 */
-(void)customTabBarButtonTitle:(NSString *)title image:(NSString *)imageName target:(id)taget action:(SEL)selector isLeft:(BOOL)isLeft{
    UIButton *button=[UIButton buttonWithType:UIButtonTypeSystem];
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:taget action:selector forControlEvents:UIControlEventTouchDown];
    button.frame=CGRectMake(0, 0, 65, 30);
    button.tag=500;
    [button setBackgroundColor:[UIColor lightGrayColor]];
    button.layer.cornerRadius=5;
    button.clipsToBounds=YES;
    button.titleLabel.font=[UIFont boldSystemFontOfSize:16];
    //判断是否为左侧按钮
    UIBarButtonItem *buttonItem=[[UIBarButtonItem alloc]initWithCustomView:button];
    if (isLeft) {
        self.navigationItem.leftBarButtonItem=buttonItem;
    }else{
        self.navigationItem.rightBarButtonItem=buttonItem;
    }
}
/**返回回调*/
-(void)onLeftClicked:(UIButton *)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
