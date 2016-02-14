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
@interface YLMainViewController ()<UIGestureRecognizerDelegate>{
    NSTimer *maketTimer;
}
@property (weak, nonatomic) IBOutlet UIImageView *niu_hosImageView;
@property (weak, nonatomic) IBOutlet UIButton *marketCount;
@property (weak, nonatomic) IBOutlet UIButton *marketPercentSH;
@property (weak, nonatomic) IBOutlet UIButton *changeCountSH;
@property (weak, nonatomic) IBOutlet UIButton *maketCountSZ;
@property (weak, nonatomic) IBOutlet UIButton *changePSZ;
@property (weak, nonatomic) IBOutlet UIButton *changeCountSZ;
@property (weak, nonatomic) IBOutlet UIButton *maketCountCREAT;
@property (weak, nonatomic) IBOutlet UIButton *changPCreat;
@property (weak, nonatomic) IBOutlet UIButton *changeCCreat;

@end

@implementation YLMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"旺旺股票";
    [self addGestureOnImageView];
    maketTimer=[NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(showMarketIndex) userInfo:nil repeats:YES];
    maketTimer.fireDate=[NSDate distantPast];

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
 *  点击手势的回调方法
 */
-(void)actionOnTap{
    YLStockHostoryViewController *historyVc=[[YLStockHostoryViewController alloc]init];
    [self.navigationController pushViewController:historyVc animated:YES];
    
}
/**
 *  大盘指数的回调方法显示
 */
-(void)showMarketIndex{
      NSString *urlStringSH=@"http://hq.sinajs.cn/list=s_sh000001";//上证指数
      NSString *urlStringCreat=@"http://hq.sinajs.cn/list=s_sz399006";//创业板
      NSString *urlStringSZ=@"http://hq.sinajs.cn/list=s_sz399001";//深证成分指数
    YLMarketIndexModel *SHModel=[YLMarketIndex requestDataFromNet:urlStringSH];
    YLMarketIndexModel *creatModel=[YLMarketIndex requestDataFromNet:urlStringCreat];
    YLMarketIndexModel *SZModel=[YLMarketIndex requestDataFromNet:urlStringSZ];
    dispatch_async(dispatch_get_main_queue(), ^{
        //上海
        [_marketCount setTitle:[ NSString stringWithFormat:@"%.2lf",[SHModel.marketCount doubleValue]]forState:UIControlStateNormal];
        [_marketPercentSH setTitle:SHModel.changePercent forState:UIControlStateNormal];
        [_changeCountSH setTitle:[ NSString stringWithFormat:@"%.2lf",[SHModel.marketChange doubleValue]] forState:UIControlStateNormal];
        //深证
        [_maketCountSZ setTitle:[ NSString stringWithFormat:@"%.2lf",[SZModel.marketCount doubleValue]]forState:UIControlStateNormal];
        [_changePSZ setTitle:SZModel.changePercent forState:UIControlStateNormal];
        [_changeCountSZ setTitle:[ NSString stringWithFormat:@"%.2lf",[SZModel.marketChange doubleValue]] forState:UIControlStateNormal];
        //创业板
        [_maketCountCREAT setTitle:[ NSString stringWithFormat:@"%.2lf",[creatModel.marketCount doubleValue]]forState:UIControlStateNormal];
        [_changPCreat setTitle:creatModel.changePercent forState:UIControlStateNormal];
        [_changeCCreat setTitle:[ NSString stringWithFormat:@"%.2lf",[creatModel.marketChange doubleValue]] forState:UIControlStateNormal];
        
        
    });

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)dealloc{
    if (maketTimer) {
        [maketTimer invalidate];
        maketTimer=nil;
    }
}
@end
