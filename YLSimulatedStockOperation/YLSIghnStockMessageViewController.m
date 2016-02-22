//
//  YLSIghnStockMessageViewController.m
//  YLSimulatedStockOperation
//
//  Created by Waterstrong on 2/13/16.
//  Copyright © 2016 hoggenWang. All rights reserved.
//

#import "YLSIghnStockMessageViewController.h"
#import "YLJudgeStcok.h"
#import "YLSignStcokMessageRequest.h"
#import "YLStockNewsViewController.h"
#import "YLStockNewsViewController.h"
#import "YLStockNoticeViewController.h"
#import "YLCrashDirectionViewController.h"
#import "YLJudgeStockViewController.h"
#import "YLSimulatedBuyViewController.h"
@interface YLSIghnStockMessageViewController (){
    NSTimer *firstTimer;
    NSTimer *secondeTimer;
    NSString *pictureURLString;
    NSString *tockPrice;
}
/**基本信息更新的视图*/
@property (weak, nonatomic) IBOutlet UILabel *costNumber3;
@property (weak, nonatomic) IBOutlet UILabel *changCount31;
@property (weak, nonatomic) IBOutlet UILabel *changePercent32;
@property (weak, nonatomic) IBOutlet UILabel *mostHigh33;
@property (weak, nonatomic) IBOutlet UILabel *mostLow34;
@property (weak, nonatomic) IBOutlet UILabel *openPrice5;
@property (weak, nonatomic) IBOutlet UILabel *tradeTotol37;
@property (weak, nonatomic) IBOutlet UILabel *chageTrade38;
@property (weak, nonatomic) IBOutlet UILabel *PE39;
@property (weak, nonatomic) IBOutlet UILabel *PB46;
@property (weak, nonatomic) IBOutlet UILabel *upStop47;
@property (weak, nonatomic) IBOutlet UILabel *downStop48;
/**图片显示信息*/
@property (weak, nonatomic) IBOutlet UIImageView *stockPictureShow;
/**回调按钮*/
@property (weak, nonatomic) IBOutlet UIButton *newsButton;
@property (weak, nonatomic) IBOutlet UIButton *tellButton;
@property (weak, nonatomic) IBOutlet UIButton *crashButton;
@property (weak, nonatomic) IBOutlet UIButton *analysisButton;

@end

@implementation YLSIghnStockMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    firstTimer=[NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(dealStockMessage) userInfo:nil repeats:YES];
    firstTimer.fireDate=[NSDate distantPast];
    [self getPictureShow:nil];
     [self customTabBarButtonTitle:@"模拟买入" image:nil target:self action:@selector(onRightClicked:)  isLeft:NO];
    [self judgeIfMarketIndex];
}
-(void)onRightClicked:(UIButton*)sender{
    if ([YLNsuserdefult judgeStockIsExist:_stockNumber]) {
        
    }else{
        [YLNsuserdefult saveSelfChioceStock:_stockNumber forKey:@"selfStocks"];
    }
    YLSimulatedBuyViewController *simulateVC=[[YLSimulatedBuyViewController alloc]init];
    simulateVC.selfTitle=self.title;
    simulateVC.stockNumber=_stockNumber;
    simulateVC.price=tockPrice;
    [self.navigationController pushViewController:simulateVC animated:YES];
}
/**新闻按钮回调方法*/
- (IBAction)getStockNews:(UIButton *)sender {
    YLStockNewsViewController *stockNewsVC=[[YLStockNewsViewController alloc]init];
    if (_stockNumber) {
       stockNewsVC.stockNumber=[YLJudgeStcok judgeStockAndDeal:_stockNumber];
        stockNewsVC.selfTitle=self.title;
       
    }
    [self.navigationController pushViewController:stockNewsVC animated:YES];
}
/**公告按钮回调方法*/
- (IBAction)tellButton:(UIButton *)sender {
    YLStockNoticeViewController *stockNoticeVC=[[YLStockNoticeViewController alloc]init];
    if (_stockNumber) {
        stockNoticeVC.stockNumber=[YLJudgeStcok judgeStockAndDeal:_stockNumber];
        stockNoticeVC.selfTitle=self.title;
    }
    [self.navigationController pushViewController:stockNoticeVC animated:YES];
}
/**
 *  资金流向回调
 */
- (IBAction)crashButton:(UIButton *)sender {
    YLCrashDirectionViewController *crashVC=[[YLCrashDirectionViewController alloc]init];
    if (_stockNumber) {
        crashVC.stockNumber=[YLJudgeStcok judgeStockAndDeal:_stockNumber];
        crashVC.selfTitle=self.title;
    }
    [self.navigationController pushViewController:crashVC animated:YES];
    
}
/**
 *  盘口分析回调
 */
- (IBAction)analysisButton:(UIButton *)sender {
    YLJudgeStockViewController *judgeVC=[[YLJudgeStockViewController alloc]init];
    if (_stockNumber) {
       judgeVC.stockNumber=[YLJudgeStcok judgeStockAndDeal:_stockNumber];
        judgeVC.selfTitle=self.title;
    }
    [self.navigationController pushViewController:judgeVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 * 判断是否是大盘指数
 */
-(void)judgeIfMarketIndex{
    if (_stockNumber) {
        NSString  *stcokString=[YLJudgeStcok judgeStockAndDeal:_stockNumber];
        if ([stcokString isEqualToString:@"sh000001"]||[stcokString isEqualToString:@"sz399006"]||[stcokString isEqualToString:@"sz399001"]) {
            _newsButton.enabled=NO;
            [_newsButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            _tellButton.enabled=NO;
              [_tellButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            _crashButton.enabled=NO;
              [_crashButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            _analysisButton.enabled=NO;
              [_analysisButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            UIBarButtonItem * rightItem = self.navigationItem.rightBarButtonItem;
            UIButton * button = rightItem.customView;
            button.enabled=NO;
           
        }else{
            _newsButton.enabled=YES;
            [_newsButton setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
            _tellButton.enabled=YES;
            [_tellButton setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
            _crashButton.enabled=YES;
            [_crashButton setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
            _analysisButton.enabled=YES;
            [_analysisButton setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
            UIBarButtonItem * rightItem = self.navigationItem.rightBarButtonItem;
            UIButton * button = rightItem.customView;
            button.enabled=YES;
        }
    }
    
}
/**
 *  进入个股信息页面处理数据
 */
-(void)dealStockMessage{
    if (_stockNumber) {
    NSString  *stcokString=[YLJudgeStcok judgeStockAndDeal:_stockNumber];
        YLSignStcokMessageRequest *dataArray=[[YLSignStcokMessageRequest alloc]init];
        dataArray.needArray=^(NSArray *array){
            dispatch_async(dispatch_get_main_queue(), ^{
                [self reloadViewInMainQueue:array];
            });
        };
        [dataArray requestStockMessage:stcokString];
    }
}
/**
 *  主程序里面更新界面
 */
-(void)reloadViewInMainQueue:(NSArray *)array{
    if (array.count>=48) {
        self.title=array[1];
        _costNumber3.text=array[3];
        tockPrice=array[3];
        _changCount31.text=array[31];
        _changePercent32.text=array[32];
        _mostHigh33.text=[NSString stringWithFormat:@"高:%@" ,array[33]];
        _mostLow34.text=[NSString stringWithFormat:@"低:%@" ,array[34]];
        _openPrice5.text=[NSString stringWithFormat:@"开:%@" ,array[5]];
        NSString *total=array[37];
        CGFloat dTotal=[total doubleValue]/10000.0;
        _tradeTotol37.text=[NSString stringWithFormat:@"额:%.2lf亿" ,dTotal];
        _chageTrade38.text=[NSString stringWithFormat:@"换:%@" ,array[38]];
        _PE39.text=[NSString stringWithFormat:@"市盈:%@" ,array[39]];
        _PB46.text=[NSString stringWithFormat:@"市净:%@" ,array[46]];
        _upStop47.text=[NSString stringWithFormat:@"涨停:%@" ,array[47]];
        _downStop48.text=[NSString stringWithFormat:@"跌停:%@" ,array[48]];
    }else{
        
    }
}
/**
 *  股票显示图片信息的获取
 */
- (IBAction)getPictureShow:(UIButton *)sender {
    NSString  *min=@"min";
    NSString *day=@"daily";
    NSString *week=@"weekly";
    NSString *month=@"monthly";
    pictureURLString=nil;
    NSMutableString *needURL=[NSMutableString string];
    secondeTimer=nil;
    [MBProgressHUD showHUDAddedTo:_stockPictureShow animated:YES];
    if (sender==nil||sender.tag==300) {
        if (_stockNumber) {
            needURL=[NSMutableString stringWithString:[NSString stringWithFormat:@"http://image.sinajs.cn/newchart/%@/n/%@.gif",min,_stockNumber]];
            pictureURLString=needURL;
            secondeTimer =[NSTimer scheduledTimerWithTimeInterval:8 target:self selector:@selector(actionPictureShow) userInfo:nil repeats:YES];
        }
    }else if (sender.tag==301){
        if (_stockNumber) {
            needURL=[NSMutableString stringWithString:[NSString stringWithFormat:@"http://image.sinajs.cn/newchart/%@/n/%@.gif",day,_stockNumber]];
            pictureURLString=needURL;
            [self actionPictureShow];
        }
        
    }else if (sender.tag==302){
        if (_stockNumber) {
            needURL=[NSMutableString stringWithString:[NSString stringWithFormat:@"http://image.sinajs.cn/newchart/%@/n/%@.gif",week,_stockNumber]];
            pictureURLString=needURL;
           [self actionPictureShow];
        }
    }else if (sender.tag==303){
        if (_stockNumber) {
            needURL=[NSMutableString stringWithString:[NSString stringWithFormat:@"http://image.sinajs.cn/newchart/%@/n/%@.gif",month,_stockNumber]];
            pictureURLString=needURL;
            [self actionPictureShow];
        }
    }
   
   
}
/**
 *  图片显示的回调信息
 */
-(void)actionPictureShow{
    UIImage *image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:pictureURLString]]];
    _stockPictureShow.image=image;
    [MBProgressHUD hideAllHUDsForView:_stockPictureShow animated:YES];
}
-(void)dealloc{
    if (firstTimer) {
        [firstTimer invalidate];
        firstTimer=nil;
    }
    if(secondeTimer){
        [secondeTimer invalidate];
        secondeTimer=nil;
    }
}
/**
 *  设置右边项
 */
-(void)customTabBarButtonTitle:(NSString *)title image:(NSString *)imageName target:(id)taget action:(SEL)selector isLeft:(BOOL)isLeft{
    UIButton *button=[UIButton buttonWithType:UIButtonTypeSystem];
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:taget action:selector forControlEvents:UIControlEventTouchDown];
    button.frame=CGRectMake(0, 0, 65, 30);
    button.tag=500;
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
@end
