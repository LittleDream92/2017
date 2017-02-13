//
//  WKWebViewController.swift
//  Swift-WebView
//
//  Created by Meng Fan on 17/2/13.
//  Copyright © 2017年 Meng Fan. All rights reserved.
//

import UIKit
import WebKit

class WKWebViewController: UIViewController , WKNavigationDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "WKWebView"

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
        
        //设置代理
        webView.navigationDelegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
        WebKit框架使得开发者可以在原生App中使用Nitro来提高网页的性能和表现，Nitro就是Safari的JavaScript引擎,WKWebView不支持JavaScriptCore的方式但提供message handler的方式为JavaScript与Native通信。
    */
    
    //MARK : WKNavigationDelegate
    //页面加载完成之后调用的方法
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        //调用原声JavaScript的代码需要在页面加载完成之后
        webView.evaluateJavaScript("showAlert('奏是一个弹框')") { (item, error) in
            //这里处理是否通过了或者执行JS错误代码
        }
    }
    

}
