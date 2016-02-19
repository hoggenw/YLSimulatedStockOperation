//
//  YLSimulatedBuyViewController.m
//  YLSimulatedStockOperation
//
//  Created by Waterstrong on 2/13/16.
//  Copyright © 2016 hoggenWang. All rights reserved.
//

#import "YLSimulatedBuyViewController.h"
#import "YLSignStcokMessageRequest.h"
#import "YLBuyStockModel.h"
@interface YLSimulatedBuyViewController (){
    NSTimer *firstTimer;
    NSInteger mytotalMoney;
}
/**股票名称*/
@property (weak, nonatomic) IBOutlet UILabel *stockNameLabel;
/**对应数组位置*/
@property (weak, nonatomic) IBOutlet UILabel *label2;
/**价格*/
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
/**买入数量*/
@property (weak, nonatomic) IBOutlet UILabel *buyNumber;

/**说明*/
@property (weak, nonatomic) IBOutlet UILabel *explain;
@property (weak, nonatomic) IBOutlet UIStepper *priceStepper;
@property (weak, nonatomic) IBOutlet UIStepper *numberStepper;

@end

@implementation YLSimulatedBuyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=_selfTitle;
    [self customTabBarButtonTitle:@"返回" image:nil target:self action:@selector(onLeftClicked:)  isLeft:YES];
    _stockNameLabel.text=_selfTitle;
    firstTimer=[NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(dealStockMessage) userInfo:nil repeats:YES];
    firstTimer.fireDate=[NSDate distantPast];
    [self reloadstockBuyIn];
   
   
   

}
/**返回回调*/
-(void)onLeftClicked:(UIButton *)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
/**更新买入界面*/
-(void)reloadstockBuyIn{
    mytotalMoney=[YLNsuserdefult getMoneyUserForKey:@"Smoney"];
    dispatch_async(dispatch_get_main_queue(), ^{
        _lable3.text=_price;
        NSInteger intPrice=[[NSString stringWithFormat:@"%.0lf",[_price doubleValue]*100] integerValue];
        _buyNumber.text=[NSString stringWithFormat:@"%ld",(mytotalMoney/(intPrice)*100)];
        _explain.text=[NSString stringWithFormat:@"可用资金%ld 最多可买入股票数量%@",mytotalMoney,_buyNumber.text];
        _numberStepper.autorepeat=YES;
        _numberStepper.maximumValue=[_buyNumber.text integerValue];
        _numberStepper.value=[_buyNumber.text integerValue];
        _numberStepper.minimumValue=0;
        _numberStepper.stepValue=100;
    });
    _priceStepper.autorepeat=YES;
    _priceStepper.value=[_price doubleValue];
    _priceStepper.minimumValue=0.01;
    _priceStepper.maximumValue=2000;
    _priceStepper.stepValue=0.01;
}
/**买入下单*/
- (IBAction)buyInOrderAction:(UIButton *)sender {
    NSString *string=[NSString stringWithFormat:@"你确定以【%@】买入%@股【%@】吗？（提醒：依据沪深交易规则，当日买入的股票需等到下个交易日才能卖出！）",_lable3.text,_buyNumber.text,_stockNameLabel.text];
    UIAlertController *ac=[UIAlertController alertControllerWithTitle:@"提示" message:string  preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([_buyNumber.text integerValue]==0) {
            YLHintView *hView=[[YLHintView alloc]initWithFrame:CGRectMake(0, 0,150, 120)];
            hView.center=self.view.center;
            [self.view addSubview:hView];
            hView.message=@"抱歉，购买数量不能为0";
            [hView showOnView:self.view ForTimeInterval:1.2];
            
        }else{
        YLBuyStockModel *model=[[YLBuyStockModel alloc]init];
        NSDate *nowDate=[NSDate date];
        model.mainKey=nowDate;
        model.stockName=_stockNameLabel.text;
        model.stockNumber=_label2.text;
        model.buyPrice=_lable3.text;
        model.buyNumber=_buyNumber.text;
        CGFloat lowPrice=[_label34.text doubleValue];
        if ([model.buyPrice doubleValue]>lowPrice) {
            model.ifTrade=1;
            
          
        }else{
            model.ifTrade=0;
        }
            NSInteger money=[YLNsuserdefult getMoneyUserForKey:@"Smoney"];
            money=money -([model.buyNumber integerValue]*[model.buyPrice integerValue]);
            [YLNsuserdefult saveMoney:money UserForKey:@"Smoney"];
            YLHintView *hView=[[YLHintView alloc]initWithFrame:CGRectMake(0, 0,150, 120)];
            hView.center=self.view.center;
            [self.view addSubview:hView];
            hView.message=@"下单成功";
            [hView showOnView:self.view ForTimeInterval:1.2];
            [[YLDataManager shareManager]insertBuyStockData:model];
            [self reloadstockBuyIn];
        }
        
    }];
    UIAlertAction *cancelAction=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [ac addAction:okAction];
    [ac addAction:cancelAction];
    [self presentViewController:ac animated:YES completion:nil];
}


/**价格的选着器*/
- (IBAction)priceStepper:(UIStepper *)sender {
    _lable3.text=[NSString stringWithFormat:@"%.2lf",sender.value];
    
}
/**数量选着器*/
- (IBAction)numberStepperAction:(UIStepper *)sender {
    if(sender.value==0){
        _buyNumber.text=@"0";
    }else{
    _buyNumber.text=[NSString stringWithFormat:@"%.0ld",(NSInteger)sender.value];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
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
        _againLabel2.text=array[3];
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
@end
