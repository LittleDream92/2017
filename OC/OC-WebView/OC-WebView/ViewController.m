//
//  ViewController.m
//  OC-WebView
//
//  Created by Meng Fan on 17/2/8.
//  Copyright © 2017年 Meng Fan. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>

@interface ViewController () <WKNavigationDelegate, WKUIDelegate>   //WKScriptMessageHandler

@property (nonatomic, strong) UIWebView *mainWebView;

@property (nonatomic, strong) WKWebView *wkWebView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 /*
    //create a webView
    self.mainWebView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.mainWebView];
    
    //适应屏幕大小
    self.mainWebView.scalesPageToFit = YES;
    
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
    
    
    //create WebView
    self.wkWebView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.wkWebView];
    
    
    //遵守协议(2个委托)
    self.wkWebView.navigationDelegate = self;
    self.wkWebView.UIDelegate = self;
    
    [self.wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
    
}


#pragma mark - WKNavigationDelegate
#pragma mark -追踪加载过程
//页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"页面开始加载时调用");
}

//当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"当内容开始返回时调用");
}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"页面加载完成之后调用");
}

//页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"页面加载失败时调用");
}
#pragma mark -进行页面跳转
//接收到服务器跳转请求之后再执行
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"接收到服务器跳转请求之后再执行");
}

//在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    NSLog(@"在收到响应后，决定是否跳转");
}

//在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
}

/*!
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error;
 
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler;
 
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView API_AVAILABLE(macosx(10.11), ios(9.0));
*/

#pragma mark - WKUIDelegate
//1.创建一个新的WebVeiw
//- (nullable WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
//
//}
//2.WebVeiw关闭（9.0中的新方法）
- (void)webViewDidClose:(WKWebView *)webView NS_AVAILABLE(10_11, 9_0) {
    
}
//3.显示一个JS的Alert（与JS交互）
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    
}
//4.弹出一个输入框（与JS交互的）
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler {
    
}
//5.显示一个确认框（JS的）
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler {
    
}

#pragma mark - 
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
