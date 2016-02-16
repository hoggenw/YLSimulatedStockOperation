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
@interface YLSIghnStockMessageViewController (){
    NSTimer *firstTimer;
    NSTimer *secondeTimer;
    NSString *pictureURLString;
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
    //[self judgeIfMarketIndex];
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
            _tellButton.enabled=NO;
            _crashButton.enabled=NO;
            _analysisButton.enabled=NO;
        }else{
            _newsButton.enabled=YES;
            _tellButton.enabled=YES;
            _crashButton.enabled=YES;
            _analysisButton.enabled=YES;
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
        _changCount31.text=array[31];
        _changePercent32.text=array[32];
        _mostHigh33.text=[NSString stringWithFormat:@"高:%@" ,array[33]];
        _mostLow34.text=[NSString stringWithFormat:@"低:%@" ,array[34]];
        _openPrice5.text=[NSString stringWithFormat:@"开:%@" ,array[5]];
        NSString *total=array[37];
        CGFloat dTotal=[total doubleValue]/10000.0;
        _tradeTotol37.text=[NSString stringWithFormat:@"额:%.0lf亿" ,dTotal];
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
@end
