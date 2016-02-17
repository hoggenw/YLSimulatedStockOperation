//
//  YLSimulatedBuyViewController.m
//  YLSimulatedStockOperation
//
//  Created by Waterstrong on 2/13/16.
//  Copyright © 2016 hoggenWang. All rights reserved.
//

#import "YLSimulatedBuyViewController.h"
#import "YLSignStcokMessageRequest.h"
@interface YLSimulatedBuyViewController (){
    NSTimer *firstTimer;
    
}
/**股票名称*/
@property (weak, nonatomic) IBOutlet UILabel *stockNameLabel;
/**对应数组位置*/
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *lable3;
@property (weak, nonatomic) IBOutlet UILabel *againLabel2;
@property (weak, nonatomic) IBOutlet UILabel *label31;
@property (weak, nonatomic) IBOutlet UILabel *label32;
@property (weak, nonatomic) IBOutlet UILabel *label5;
@property (weak, nonatomic) IBOutlet UILabel *label4;
@property (weak, nonatomic) IBOutlet UILabel *label33;
@property (weak, nonatomic) IBOutlet UILabel *label34;
@property (weak, nonatomic) IBOutlet UILabel *label36;
@property (weak, nonatomic) IBOutlet UILabel *label37;
@property (weak, nonatomic) IBOutlet UILabel *label9;
@property (weak, nonatomic) IBOutlet UILabel *label10;
@property (weak, nonatomic) IBOutlet UILabel *label11;
@property (weak, nonatomic) IBOutlet UILabel *label12;
@property (weak, nonatomic) IBOutlet UILabel *label13;
@property (weak, nonatomic) IBOutlet UILabel *label14;
@property (weak, nonatomic) IBOutlet UILabel *label15;
@property (weak, nonatomic) IBOutlet UILabel *label16;
@property (weak, nonatomic) IBOutlet UILabel *label17;
@property (weak, nonatomic) IBOutlet UILabel *label18;
@property (weak, nonatomic) IBOutlet UILabel *label19;
@property (weak, nonatomic) IBOutlet UILabel *label20;
@property (weak, nonatomic) IBOutlet UILabel *label21;
@property (weak, nonatomic) IBOutlet UILabel *label22;
@property (weak, nonatomic) IBOutlet UILabel *label23;
@property (weak, nonatomic) IBOutlet UILabel *label24;
@property (weak, nonatomic) IBOutlet UILabel *label25;
@property (weak, nonatomic) IBOutlet UILabel *label26;
@property (weak, nonatomic) IBOutlet UILabel *label27;
@property (weak, nonatomic) IBOutlet UILabel *labal28;

@end

@implementation YLSimulatedBuyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=_selfTitle;
    _stockNameLabel.text=_selfTitle;
    firstTimer=[NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(dealStockMessage) userInfo:nil repeats:YES];
    firstTimer.fireDate=[NSDate distantPast];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        _label2.text=array[2];
        _againLabel2.text=array[2];
        _lable3.text=array[3];
        _label31.text=array[31];
        _label32.text=[NSString stringWithFormat:@"%.2lf%%",[array[32] doubleValue]];
        _label5.text=array[5];
        _label4.text=array[4];
        _label33.text=array[33];
        _label34.text=array[34];
        _label36.text=array[36];
        _label37.text=array[37];
        _label9.text=array[9];
        _label10.text=array[10];
        _label11.text=array[11];
        _label12.text=array[12];
        _label13.text=array[13];
        _label14.text=array[14];
        _label15.text=array[15];
        _label16.text=array[16];
        _label17.text=array[17];
        _label18.text=array[18];
        _label19.text=array[19];
        _label20.text=array[20];
        _label21.text=array[21];
        _label22.text=array[22];
        _label23.text=array[23];
        _label24.text=array[24];
        _label25.text=array[25];
        _label26.text=array[26];
        _label27.text=array[27];
        _labal28.text=array[28];
    
    }else{
        
    }
}
-(void)dealloc{
    if (firstTimer) {
        [firstTimer invalidate];
        firstTimer=nil;
    }
}
@end
