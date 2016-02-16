//
//  YLDetailNewsViewController.m
//  YLSimulatedStockOperation
//
//  Created by 千锋 on 16/2/16.
//  Copyright © 2016年 hoggenWang. All rights reserved.
//

#import "YLDetailNewsViewController.h"

@interface YLDetailNewsViewController ()
@property (weak, nonatomic) IBOutlet UITextView *detailNews;

@end

@implementation YLDetailNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (_urlString) {
        self.title=_selfTitle;
        [MBProgressHUD showHUDAddedTo:_detailNews animated:YES];
        [self requestStockNews:_urlString];
    }else{
        
    }
    
    // Do any additional setup after loading the view from its nib.
}
/**
 *  请求股票新闻
 */
-(void)requestStockNews:(NSString *)urlString{
    NSURLSession *mySession=[NSURLSession sharedSession];
    NSURLSessionDataTask *myTask=[mySession dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSString *textString=dict[@"text"];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.title=dict[@"title"];
                _detailNews.text=textString;
                [MBProgressHUD hideAllHUDsForView:_detailNews animated:YES];
            });
        }else{
            
        }
    }];
    [myTask resume];
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

@end
