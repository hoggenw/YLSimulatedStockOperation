//
//  YLJudgeStockViewController.m
//  YLSimulatedStockOperation
//
//  Created by 千锋 on 16/2/17.
//  Copyright © 2016年 hoggenWang. All rights reserved.
//

#import "YLJudgeStockViewController.h"
#import "YLTheFastNew.h"
@interface YLJudgeStockViewController ()
@property (weak, nonatomic) IBOutlet UILabel *buyBig;

@property (weak, nonatomic) IBOutlet UILabel *buyLittle;
@property (weak, nonatomic) IBOutlet UILabel *sellBig;
@property (weak, nonatomic) IBOutlet UILabel *sellLittle;
@property (weak, nonatomic) IBOutlet UILabel *judgeLabel;
@property (weak, nonatomic) IBOutlet UILabel *nowStatus;

@end

@implementation YLJudgeStockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (_stockNumber) {
        [self requestDataForChangeView];
        self.title=_selfTitle;
    }else{
        //似乎没有数据
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  请求数据，改变页面
 */
-(void)requestDataForChangeView{
    YLTheFastNew *newGet=[[YLTheFastNew alloc]init];
    YLTheFastNew *newGet1=[[YLTheFastNew alloc]init];
    __weak typeof(self) weakSelf=self;
    newGet.needArray=^(NSArray *array){
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf  changeView:array];
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        });
        
    };
    [newGet requestStockJudegeDatas:_stockNumber];
    newGet1.needArray=^(NSArray *array){
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf  changeView1:array];
        });
        
    };
    [newGet1 requestJudgeStock:_stockNumber];
   
}
/**
 *  改变页面
 */
-(void)changeView:(NSArray *)array{
    if (array.count>=4) {
        _buyBig.text=array[0];
        _buyLittle.text=array[1];
        _sellBig.text=array[2];
        _sellLittle.text=array[3];
    }
}
-(void)changeView1:(NSArray *)array{
    if (array.count>=2) {
        _judgeLabel.text=array[0];
        _nowStatus.text=array[1];
        
    }
}
@end
