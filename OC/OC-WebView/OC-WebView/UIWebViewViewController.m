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
    
    //加载本地HTML文件
    NSString *path = [[NSBundle mainBundle] pathForResource:@"html" ofType:@"html"];
    NSFileHandle *readHandle = [NSFileHandle fileHandleForReadingAtPath:path];
    NSString *htmlString = [[NSString alloc] initWithData:[readHandle readDataToEndOfFile] encoding:NSUTF8StringEncoding];
    [self.mainWebView loadHTMLString:htmlString baseURL:nil];
    
    //加载URL
//    [self.mainWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
    
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

#pragma mark - action
/**  *  打电话  */
-(void)call:(NSString*)phone{
    NSLog(@"call......:%@",phone);
}

/**   *  打开照相机  */
-(void)openCanmera{
    NSLog(@"openCanmera......");
}

#pragma mark - UIWebViewDelegate
//webView即将加载的时候，通过返回值确定是否加载
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    //可以在此处通过拦截request获取即将跳转的信息和相应的type：navigationType
    
    //在JS中调用OC
    NSString *url = request.URL.absoluteString;
    NSLog(@"链接: %@", url);
//    [urlhasPrefix:@"tooc://"];
   
    NSRange range = [url rangeOfString:@"tooc://"];
    NSUInteger loc = range.location;
    if (loc != NSNotFound) {
    
        // 方法名
        NSString *method = [url substringFromIndex:loc + range.length];
        NSLog(@"method:%@",method);
        // 将方法名转成SEL
        SEL sel = NSSelectorFromString(method);
        if ([self respondsToSelector:sel]) {
            [self performSelector:sel withObject:nil];
        }
    }
    
    
    return YES;
}


//webView开始加载的时候
- (void)webViewDidStartLoad:(UIWebView *)webView {
    
}

//webView结束加载的时候
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    //OC调用JS交互（掌握一些基本的html语法和JS语法）
    
    //1、读取当前页面的URL
    // document.location.href是获取网页url的js语法，意思是，webView执行以下这句js代码，就会返回我们想要的网页地址，进而知道用户的访问量
    NSString *url = [webView stringByEvaluatingJavaScriptFromString:@"document.location.href"];
    NSLog(@"local url : %@", url);
    
    //2、读取当前页面的标题
    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    NSLog(@"local title : %@", title);
    
    //3、JS1是JS获取标签元素a的方法，JS2是将a删除，实现了动态删除标签a的功能，实现了交互
    NSString *js1 = @"var a = document.getElementByTagName('a')[1]";
    [webView stringByEvaluatingJavaScriptFromString:js1];
    
    NSString *js2 = @"a.parentNode.removeChild(a)";
    [webView stringByEvaluatingJavaScriptFromString:js2];
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
