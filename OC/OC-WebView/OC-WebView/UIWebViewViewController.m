//
//  UIWebViewViewController.m
//  OC-WebView
//
//  Created by Meng Fan on 17/2/9.
//  Copyright © 2017年 Meng Fan. All rights reserved.
//

#import "UIWebViewViewController.h"

@interface UIWebViewViewController () <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *mainWebView;

@end

@implementation UIWebViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //create a webView
    self.mainWebView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.mainWebView];
    
    //适应屏幕大小
    self.mainWebView.scalesPageToFit = YES;
    
    //设置代理
    self.mainWebView.delegate = self;
    
    [self.mainWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
    
    /*
     //加载数据的三种方式
     //1. 通过URL来进行加载,URL可以是远程的也可以是本地的
     NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
     NSURLRequest *request = [NSURLRequest requestWithURL:url];
     [self.mainWebView loadRequest:request];
     
     //2. 通过将html文件读取为字符串，其中baseURL是自己设置的路径，用于寻找html文件中引用的图片等素材
     NSData *htmlData = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://www.baidu.com"]];
     
     //2.1 如果网页是国际通用的UTF-8编码的话，可以直接转为字符串
     //    NSString *pageSource = [[NSString alloc] initWithData:htmlData encoding:NSUTF8StringEncoding];
     
     //2.2 如果网页是汉字的GBK编码（或者gb2312）的话，可以以下方法转字符串
     NSStringEncoding gbkEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
     NSString *pageSource = [[NSString alloc] initWithData:htmlData encoding:gbkEncoding];
     
     NSLog(@"%@", pageSource);
     [self.mainWebView loadHTMLString:pageSource baseURL:[NSURL URLWithString:@"https://www.com"]];
     
     
     
     NSString *bodyString;   //html 中 body的具体内容
     
     NSString *htmlPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"index.html"];
     NSString *content = [[NSString alloc] initWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
     htmlPath = [NSString stringWithFormat:content, bodyString];
     [self.mainWebView loadHTMLString:htmlPath baseURL:nil];
     
     //3. 通过二进制文件加载数据
     NSData *data;
     [self.mainWebView loadData:data
     MIMEType:@"image/gif"
     textEncodingName:@"UTF-8"
     baseURL:[NSURL URLWithString:@""]];
     */
    

}

#pragma mark - UIWebViewDelegate
//webView即将加载的时候，通过返回值确定是否加载
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
}


//webView开始加载的时候
- (void)webViewDidStartLoad:(UIWebView *)webView {
    
}

//webView结束加载的时候
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
}

//webView加载出错的时候
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
}



#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
