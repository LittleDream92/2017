//
//  WKWebViewController.swift
//  Swift-WebView
//
//  Created by Meng Fan on 17/2/13.
//  Copyright © 2017年 Meng Fan. All rights reserved.
//

import UIKit
import WebKit

class WKWebViewController: UIViewController  , WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler {

    override func viewDidLoad() {
        super.viewDidLoad()
        //Type 'WKWebViewController' does not conform to protocol 'WKScriptMessageHandler'
        title = "WKWebView"
        
        //关于WebView的学习资料：http://www.jianshu.com/p/403853b63537
        
        
/*  1.
        // 创建WKWebView
        let webView = WKWebView(frame: UIScreen.main.bounds)
        // 设置访问的URL
        let url = NSURL(string: "http://www.jianshu.com")
        // 根据URL创建请求
        let requst = NSURLRequest(url: url! as URL)
        // WKWebView加载请求
        webView.load(requst as URLRequest)
        // 将WKWebView添加到视图
        view.addSubview(webView)
*/
        
        
/*  2.
         
*/
        //创建配置
        let config = WKWebViewConfiguration()
        //创建UserContentController（提供JavaScript向web View发送消息的方法）
        let userContent = WKUserContentController()
        //添加消息处理，注意：self指代的对象需要遵守wkScriptHandle协议，结束时需要移除
        userContent.add(self, name: "NativeMethod")
        //将UserContentController设置到配置文件
        config.userContentController = userContent
        
        
        // 创建WKWebView
        let webView = WKWebView(frame: UIScreen.main.bounds, configuration: config)
        // 设置访问的URL
        let url = NSURL(string: "http://www.jianshu.com")
        // 根据URL创建请求
        let requst = NSURLRequest(url: url! as URL)
        // WKWebView加载请求
        webView.load(requst as URLRequest)
        // 将WKWebView添加到视图
        view.addSubview(webView)
        
        //WKWebView有个内置的scrollView，也可以通过scrollView设置偏移量
        webView.scrollView.contentInset = UIEdgeInsetsMake(40, 0, 0, 0)
        
        //设置代理
        webView.navigationDelegate = self
        webView.uiDelegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

    /*
        WebKit框架使得开发者可以在原生App中使用Nitro来提高网页的性能和表现，Nitro就是Safari的JavaScript引擎,WKWebView不支持JavaScriptCore的方式但提供message handler的方式为JavaScript与Native通信。
    */
    
    //MARK: WKNavigationDelegate
    //页面加载完成之后调用的方法
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        //调用原声JavaScript的代码需要在页面加载完成之后
        webView.evaluateJavaScript("showAlert('奏是一个弹框')") { (item, error) in
            //这里处理是否通过了或者执行JS错误代码
        }
    }
    
    
    //MARK: WKScriptMessageHandler
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print("我是协议方法MessageHandler")
    }
    
}
