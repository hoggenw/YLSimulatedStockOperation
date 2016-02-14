//
//  YLStockHostoryViewController.m
//  YLSimulatedStockOperation
//
//  Created by Waterstrong on 2/14/16.
//  Copyright © 2016 hoggenWang. All rights reserved.
//

#import "YLStockHostoryViewController.h"

@interface YLStockHostoryViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *myWebView;

@end

@implementation YLStockHostoryViewController

- (void)viewDidLoad {
    self.title=@"近期牛股";
    [super viewDidLoad];
    NSString *urlString=@"http://res.gupiaoxianji.com/banner_html/stock_html/stocks.html";
    [_myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
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
