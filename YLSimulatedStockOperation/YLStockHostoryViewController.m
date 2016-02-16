//
//  YLStockHostoryViewController.m
//  YLSimulatedStockOperation
//
//  Created by Waterstrong on 2/14/16.
//  Copyright © 2016 hoggenWang. All rights reserved.
//

#import "YLStockHostoryViewController.h"

@interface YLStockHostoryViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *myWebView;

@end

@implementation YLStockHostoryViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    _myWebView.delegate=self;
    if (_URLString==nil) {
    NSString *urlString=@"http://res.gupiaoxianji.com/banner_html/stock_html/stocks.html";
        
         [_myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
        self.title=@"近期牛股";
    }else{
         [_myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_URLString]]];
        self.title=@"资讯快报";
    }
 
   
}
//在webView开始加载时会调用该函数，我们在这里显示
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showHUDAddedTo:_myWebView animated:YES];
}

//在webView加载完毕时会调用该函数，我们在这里把移除掉
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideAllHUDsForView:_myWebView animated:YES];
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
