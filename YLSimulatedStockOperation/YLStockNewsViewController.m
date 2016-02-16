//
//  YLStockNewsViewController.m
//  YLSimulatedStockOperation
//
//  Created by 千锋 on 16/2/16.
//  Copyright © 2016年 hoggenWang. All rights reserved.
//

#import "YLStockNewsViewController.h"
#import "YLStockNewsTableViewCell.h"
#import "YLStockNewsModel.h"
#import "YLTheFastNew.h"
#import "YLDetailNewsViewController.h"
@interface YLStockNewsViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *dataArray;
}
@property (weak, nonatomic) IBOutlet UITableView *newsTableView;

@end

@implementation YLStockNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (_stockNumber) {
      [self creatTableViewShow];
        self.title=_selfTitle;
    }else{
        //似乎没有数据
    }
    
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
    __weak typeof(self) weakSelf=self;
    [_newsTableView registerNib:[UINib nibWithNibName:@"YLStockNewsTableViewCell" bundle:nil] forCellReuseIdentifier:@"CELL"];
    _newsTableView.delegate=self;
    _newsTableView.dataSource=self;
    YLTheFastNew *newGet=[[YLTheFastNew alloc]init];
    newGet.needArray=^(NSArray *array){
        dataArray=[NSMutableArray arrayWithArray:array];
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.newsTableView reloadData];
            [MBProgressHUD hideAllHUDsForView:_newsTableView animated:YES];
        });
        
    };
    [newGet requestStockNews:_stockNumber];
    [MBProgressHUD showHUDAddedTo:_newsTableView animated:YES];
}
/**
 *  tableView回调
 */
//组中单元格数组
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YLStockNewsTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if (!cell) {
        cell=[[YLStockNewsTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CELL"];
    }
    cell.model=dataArray[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    YLDetailNewsViewController *detailNewVC=[[YLDetailNewsViewController alloc]init];
    YLStockNewsModel *model=dataArray[indexPath.row];
    detailNewVC.urlString=model.url;
    detailNewVC.selfTitle=self.title;
    [self.navigationController pushViewController:detailNewVC animated:YES];
    
}


@end
