//
//  YLCrashDirectionViewController.m
//  YLSimulatedStockOperation
//
//  Created by 千锋 on 16/2/17.
//  Copyright © 2016年 hoggenWang. All rights reserved.
//

#import "YLCrashDirectionViewController.h"
#import "YLTheFastNew.h"
@interface YLCrashDirectionViewController (){
   
}
@property (weak, nonatomic) IBOutlet UILabel *ZLin;
@property (weak, nonatomic) IBOutlet UILabel *ZLout;

@property (weak, nonatomic) IBOutlet UILabel *ZLtotol;
@property (weak, nonatomic) IBOutlet UILabel *SHin;
@property (weak, nonatomic) IBOutlet UILabel *SHout;
@property (weak, nonatomic) IBOutlet UILabel *SHtotal;

@end

@implementation YLCrashDirectionViewController

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
    __weak typeof(self) weakSelf=self;
    newGet.needArray=^(NSArray *array){
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf  changeView:array];
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        });
        
    };
    [newGet requestStockCrashData:_stockNumber];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}
/**
 *  改变页面
 */
-(void)changeView:(NSArray *)array{
    if (array.count>=10) {
        _ZLin.text=array[1];
        _ZLout.text=array[2];
        _ZLtotol.text=array[3];
        _SHin.text=array[5];
        _SHout.text=array[6];
        _SHtotal.text=array[7];
    }
}
@end
