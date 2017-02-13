//
//  WKWebViewViewController.m
//  OC-WebView
//
//  Created by Meng Fan on 17/2/9.
//  Copyright © 2017年 Meng Fan. All rights reserved.
//

#import "WKWebViewViewController.h"
#import <WebKit/WebKit.h>

@interface WKWebViewViewController () <WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler>

@property (nonatomic, strong) WKWebView *wkWebView;

@end

@implementation WKWebViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
   
    //create a WKWebView
    self.wkWebView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    //加载网页数据（URL、NSString、NSDATA3种方式）
    [self.wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
    //将WKWebView添加到视图
    [self.view addSubview:self.wkWebView];
    
//    //遵守协议(2个委托)
//    self.wkWebView.navigationDelegate = self;
//    self.wkWebView.UIDelegate = self;
    
    
     /*
    //动态加载并运行JS代码
    // 图片缩放的js代码
    NSString *js = @"var count = document.images.length;for (var i = 0; i < count; i++) {var image = document.images[i];image.style.width=375;};window.alert('找到' + count + '张图');";
    // 根据JS字符串初始化WKUserScript对象
    WKUserScript *script = [[WKUserScript alloc] initWithSource:js injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    // 根据生成的WKUserScript对象，初始化WKWebViewConfiguration
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    [config.userContentController addUserScript:script];
    self.wkWebView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:config];
    [self.wkWebView loadHTMLString:@"<head></head><img src='http://www.nsu.edu.cn/v/2014v3/img/background/3.jpg' />"baseURL:nil];

    self.wkWebView.UIDelegate = self;
    self.wkWebView.navigationDelegate = self;
    
    [self.view addSubview:self.wkWebView];
    */
    
    //  问题小结:
    // iOS 8 下WKWebView不支持加载本地HTML，iOS 9开始支持
    // UIWebView 上的修改UserAgent的方法在WKWebView上不起作用，可以参考一下stackOverFlow上的解决方案：http://stackoverflow.com/questions/26994491/set-useragent-in-wkwebview
    
    
}

#pragma mark - 
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - WKNavigationDelegate
#pragma mark -追踪加载过程(加载的状态回调)
//页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"页面开始加载时调用: %s", __FUNCTION__);
}

//当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"当内容开始返回时调用: %s", __FUNCTION__);
}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"页面加载完成之后调用: %s", __FUNCTION__);
    
    //原声调用JavaScript代码需要在页面加载完毕之后
    [self.wkWebView evaluateJavaScript:@"showAlert('奏是一个弹框')" completionHandler:^(id _Nullable item, NSError * _Nullable error) {
        //这里处理是否通过了或者执行JS错误的代码
    }];
}

//页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"页面加载失败时调用: %s", __FUNCTION__);
}


#pragma mark -进行页面跳转
//接收到服务器跳转请求之后再执行
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"接收到服务器跳转请求之后再执行: %s", __FUNCTION__);
}

//在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    NSLog(@"在收到响应后，决定是否跳转: %s", __FUNCTION__);
    // 如果响应的地址是百度，则允许跳转
    if ([navigationResponse.response.URL.host.lowercaseString isEqual:@"www.baidu.com"]) {
        
        // 允许跳转
        decisionHandler(WKNavigationResponsePolicyAllow);
        return;
    }
    // 不允许跳转
    decisionHandler(WKNavigationResponsePolicyCancel);
}

//在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    // 如果请求的是百度地址，则延迟5s以后跳转
    if ([navigationAction.request.URL.host.lowercaseString isEqual:@"www.baidu.com"]) {
        
        // 延迟5s之后跳转
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

            // 允许跳转
            decisionHandler(WKNavigationActionPolicyAllow);
        });
        
        return;
    }
    // 不允许跳转
    decisionHandler(WKNavigationActionPolicyCancel);
}





/*
 - (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error;
 
 - (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler;
 
 - (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView API_AVAILABLE(macosx(10.11), ios(9.0));


#pragma mark - WKUIDelegate
////1.创建一个新的WebVeiw
//- (nullable WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
//
//}

//2.WebVeiw关闭（9.0中的新方法）
- (void)webViewDidClose:(WKWebView *)webView NS_AVAILABLE(10_11, 9_0) {
    
}
 */
/*3.显示一个JS的Alert（与JS交互）
    @param  webView             实现该代理的WebView
    @param  message             警告框中的内容
    @param  frame               主窗口
    @param  completionHandler   警告框消失调用

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    
}
//4.弹出一个输入框（与JS交互的）
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler {
    
}
//5.显示一个确认框（JS的）
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler {
    
}
 */


#pragma mark - WKScriptMessageHandler
// 从web界面中接收到一个脚本时调用
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    NSLog(@"%s \n %@", __FUNCTION__, message);
}

@end
