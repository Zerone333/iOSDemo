//
//  YZWebViewController.m
//  Demo
//
//  Created by administrator on 2020/7/2.
//  Copyright © 2020 administrator. All rights reserved.
//

#import "YZWebViewController.h"
#import <WebKit/WebKit.h>

@interface YZWebViewController ()

@end

@implementation YZWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WKWebView *webview = [[WKWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:webview];
    [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://h5web.meisuitv.com/h5/2.7.3/privilege.html#60"]]];
//    [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]]];
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
