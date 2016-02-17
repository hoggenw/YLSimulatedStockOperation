//
//  YLMainViewController.m
//  YLSimulatedStockOperation
//
//  Created by Waterstrong on 2/12/16.
//  Copyright © 2016 hoggenWang. All rights reserved.
//

#import "YLMainViewController.h"
#import "YLStockHostoryViewController.h"
#import "YLMarketIndexModel.h"
#import "YLMarketIndex.h"
#import "YLNewsTableViewCell.h"
#import "YLTheFastNew.h"
#import "YLFastNewsModel.h"
#import "YLSIghnStockMessageViewController.h"
#import "YLSearchStockViewController.h"
#import "YLSelfStcocksViewController.h"
@interface YLMainViewController ()<UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource>{
    NSTimer *maketTimer;
    NSMutableArray *dataArray;
    YLMarketIndexModel *SHModel;
    YLMarketIndexModel *creatModel;
    YLMarketIndexModel *SZModel;
}


/**牛股页面*/
@property (weak, nonatomic) IBOutlet UIImageView *niu_hosImageView;
/**大盘显示*/
@property (weak, nonatomic) IBOutlet UIButton *marketCount;
@property (weak, nonatomic) IBOutlet UIButton *marketPercentSH;
@property (weak, nonatomic) IBOutlet UIButton *changeCountSH;
@property (weak, nonatomic) IBOutlet UIButton *maketCountSZ;
@property (weak, nonatomic) IBOutlet UIButton *changePSZ;
@property (weak, nonatomic) IBOutlet UIButton *changeCountSZ;
@property (weak, nonatomic) IBOutlet UIButton *maketCountCREAT;
@property (weak, nonatomic) IBOutlet UIButton *changPCreat;
@property (weak, nonatomic) IBOutlet UIButton *changeCCreat;
/**新闻显示*/
@property (weak, nonatomic) IBOutlet UITableView *myNewsTableView;
/**大盘进入显示*/
@property (weak, nonatomic) IBOutlet UIView *SHMarketIndex;
@property (weak, nonatomic) IBOutlet UIView *SZMarketIndex;
@property (weak, nonatomic) IBOutlet UIView *SZCreatIndex;

@end

@implementation YLMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"旺旺股票";
    [self customTabBarButtonTitle:nil image:@"612_mine_sel" target:self action:@selector(onLeftClicked:)  isLeft:YES];
    [self addGestureOnImageView];
    maketTimer=[NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(showMarketIndex) userInfo:nil repeats:YES];
    maketTimer.fireDate=[NSDate distantPast];
    [self creatTableViewShow];
    [self addTapgestureOnViewShow];

}

/**
 *  给imageView添加手势操作，进入牛股页面
 */
-(void)addGestureOnImageView{
    UITapGestureRecognizer *gestureTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(actionOnTap)];
    gestureTap.delegate=self;
    [_niu_hosImageView addGestureRecognizer:gestureTap];
    
}
/**
 *行情点击回调
 */
- (IBAction)quotation:(UIButton *)sender {
    [self creatTableViewShow];
   
}
/**
 *  个股查询回调方法
 */
- (IBAction)searchStock:(UIButton *)sender {
    YLSearchStockViewController *searchVC=[[YLSearchStockViewController alloc]init];
    [self.navigationController pushViewController:searchVC animated:YES];
}
/**自选股回调方法*/
- (IBAction)selfButtonAction:(UIButton *)sender {
    YLSelfStcocksViewController *selfStcoksVC=[[YLSelfStcocksViewController alloc]init];
    [self.navigationController pushViewController:selfStcoksVC animated:YES];
}

/**
 *  添加大盘显示的点击回调方法
 */
-(void)addTapgestureOnViewShow{
    UITapGestureRecognizer *gestureTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapactionToShow:)];
    gestureTap.view.tag=201;
     UITapGestureRecognizer *gestureTap1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapactionToShow:)];
    gestureTap1.view.tag=202;
     UITapGestureRecognizer *gestureTap2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapactionToShow:)];
    gestureTap2.view.tag=203;
    gestureTap.delegate=self;
    gestureTap1.delegate=self;
    gestureTap2.delegate=self;
    [_SHMarketIndex addGestureRecognizer:gestureTap];
    [_SZMarketIndex addGestureRecognizer:gestureTap1];
    [_SZCreatIndex addGestureRecognizer:gestureTap2];
}
/**
 *  点击手势的回调方法
 */
-(void)actionOnTap{
    YLStockHostoryViewController *historyVc=[[YLStockHostoryViewController alloc]init];
    [self.navigationController pushViewController:historyVc animated:YES];
    
}
-(void)TapactionToShow:(UITapGestureRecognizer *)sender{
    YLSIghnStockMessageViewController *signStockVC=[[YLSIghnStockMessageViewController alloc]init];
    if (sender.view.tag==201) {
        signStockVC.stockNumber=@"sh000001";
    }else if(sender.view.tag==202){
        signStockVC.stockNumber=@"sz399001";
    }else if (sender.view.tag==203){
        signStockVC.stockNumber=@"sz399006";
    }
    
    [self.navigationController pushViewController:signStockVC animated:YES];
}
/**
 *  大盘指数的回调方法显示
 */
-(void)showMarketIndex{
      NSString *urlStringSH=@"http://hq.sinajs.cn/list=s_sh000001";//上证指数
      NSString *urlStringCreat=@"http://hq.sinajs.cn/list=s_sz399006";//创业板
      NSString *urlStringSZ=@"http://hq.sinajs.cn/list=s_sz399001";//深证成分指数
    YLMarketIndex *maketIndex=[[YLMarketIndex alloc]init];
    YLMarketIndex *maketIndex1=[[YLMarketIndex alloc]init];
    YLMarketIndex *maketIndex2=[[YLMarketIndex alloc]init];
    SHModel=[[YLMarketIndexModel alloc]init];
    creatModel=[[YLMarketIndexModel alloc]init];
    SZModel=[[YLMarketIndexModel alloc]init];
    maketIndex.needModel=^(YLMarketIndexModel *model){
        SHModel= model;
        dispatch_async(dispatch_get_main_queue(), ^{
            //上海
            [_marketCount setTitle:[ NSString stringWithFormat:@"%.2lf",[SHModel.marketCount doubleValue]]forState:UIControlStateNormal];
            [_marketPercentSH setTitle:SHModel.changePercent forState:UIControlStateNormal];
            [_changeCountSH setTitle:[ NSString stringWithFormat:@"%.2lf",[SHModel.marketChange doubleValue]] forState:UIControlStateNormal];
        });
    };
    [maketIndex requestDataFromNet:urlStringSH];
    
    maketIndex1.needModel=^(YLMarketIndexModel *model){
        creatModel=model;
        dispatch_async(dispatch_get_main_queue(), ^{
            //创业板
            [_maketCountCREAT setTitle:[ NSString stringWithFormat:@"%.2lf",[creatModel.marketCount doubleValue]]forState:UIControlStateNormal];
            [_changPCreat setTitle:creatModel.changePercent forState:UIControlStateNormal];
            [_changeCCreat setTitle:[ NSString stringWithFormat:@"%.2lf",[creatModel.marketChange doubleValue]] forState:UIControlStateNormal];
        });
    };
    [maketIndex1 requestDataFromNet:urlStringCreat];
    
    maketIndex2.needModel=^(YLMarketIndexModel *model){
        SZModel=model;
     
        dispatch_async(dispatch_get_main_queue(), ^{
            //深证
            [_maketCountSZ setTitle:[ NSString stringWithFormat:@"%.2lf",[SZModel.marketCount doubleValue]]forState:UIControlStateNormal];
            [_changePSZ setTitle:SZModel.changePercent forState:UIControlStateNormal];
            [_changeCountSZ setTitle:[ NSString stringWithFormat:@"%.2lf",[SZModel.marketChange doubleValue]] forState:UIControlStateNormal];
        });
    };
    [maketIndex2 requestDataFromNet:urlStringSZ];

}
/**
 *  tableView视图
 */

-(void)creatTableViewShow{
    __weak typeof(self) weakSelf=self;
    [_myNewsTableView registerNib:[UINib nibWithNibName:@"YLNewsTableViewCell" bundle:nil] forCellReuseIdentifier:@"CELL"];
    _myNewsTableView.delegate=self;
    _myNewsTableView.dataSource=self;
    YLTheFastNew *newGet=[[YLTheFastNew alloc]init];
    newGet.needArray=^(NSArray *array){
        dataArray=[NSMutableArray arrayWithArray:array];
        dispatch_async(dispatch_get_main_queue(), ^{
           [weakSelf.myNewsTableView reloadData];
            [MBProgressHUD hideAllHUDsForView:_myNewsTableView animated:YES];
        });
        
    };
    [newGet requestDataTheFastNews];
    [MBProgressHUD showHUDAddedTo:_myNewsTableView animated:YES];
}
/**
 *  tableView回调
 */
//组中单元格数组
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YLNewsTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if (!cell) {
        cell=[[YLNewsTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CELL"];
    }
    cell.model=dataArray[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    YLStockHostoryViewController *historyVc=[[YLStockHostoryViewController alloc]init];
    YLFastNewsModel *model=dataArray[indexPath.row];
    historyVc.URLString=model.n_id;
    [self.navigationController pushViewController:historyVc animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  设置左边项
 */
-(void)customTabBarButtonTitle:(NSString *)title image:(NSString *)imageName target:(id)taget action:(SEL)selector isLeft:(BOOL)isLeft{
    UIButton *button=[UIButton buttonWithType:UIButtonTypeSystem];
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:taget action:selector forControlEvents:UIControlEventTouchDown];
    button.frame=CGRectMake(0, 0, 35, 40);
    button.layer.cornerRadius=5;
    button.clipsToBounds=YES;
    button.titleLabel.font=[UIFont boldSystemFontOfSize:22];
    //判断是否为左侧按钮
    UIBarButtonItem *buttonItem=[[UIBarButtonItem alloc]initWithCustomView:button];
    if (isLeft) {
        self.navigationItem.leftBarButtonItem=buttonItem;
    }else{
        self.navigationItem.rightBarButtonItem=buttonItem;
    }
}
-(void)onLeftClicked:(UIButton*)sender{
    [self.sideMenuViewController presentLeftMenuViewController];
}
-(void)dealloc{
    if (maketTimer) {
        [maketTimer invalidate];
        maketTimer=nil;
    }
}
@end
