//
//  WKWebviewEngine.swift
//  ZDXMVVMSwiftProject
//
//  Created by Elbert on 17/4/20.
//  Copyright © 2017年 Elbert. All rights reserved.
//

import Foundation
import UIKit
import WebKit


class WKWebviewEngine: UIViewController,WKNavigationDelegate,WKUIDelegate ,WKScriptMessageHandler{
    //
    var wkWebView :WKWebView!
    var wkurl :NSURL!
    var wkrequest :NSURLRequest!
    var progressView:UIProgressView!
    
    
    override func viewDidLoad() {
        //
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let statusHeight = UIApplication.shared.statusBarFrame.height
        
        let navHeight = self.navigationController?.navigationBar.frame.height
        let wkWebView_Y = statusHeight+navHeight!
        print("\(statusHeight)-----\(String(describing: navHeight))-----\(view.frame.height)")
        
        let backButton = UIBarButtonItem.init(title: "back", style: .plain, target: self, action: #selector(WKWebviewEngine.backAction))
        let forwardButton = UIBarButtonItem.init(title: "forward", style: .plain, target: self, action: #selector(WKWebviewEngine.forwardAction))
        self.navigationItem.rightBarButtonItems = [backButton,forwardButton]
        //self.navigationItem.rightBarButtonItem = forwardButton
        
        
        
//        runHtmlUrlString()
        
        runHtmlFile()
        
        addSubKVOSever()
        
        
        
    }
    
    func runHtmlUrlString() -> Void {
        //
        let urlStr1 :NSString! = "http://www.jianshu.com"
        let urlStr2 :NSString! = "http://evt.tiancity.com/csol2/1565/home/index.php"
        let urlStr3 :NSString! = "https://www.baidu.com"
        
        
        wkWebView = WKWebView()
        
        
        wkWebView.frame = CGRect.init(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        wkurl = NSURL.init(string: urlStr3 as String)
        wkrequest = NSURLRequest.init(url: wkurl as URL)
        wkWebView.load(wkrequest as URLRequest)
        
        wkWebView.navigationDelegate = self
        wkWebView.uiDelegate = self
        
        view.addSubview(wkWebView)
        print("wkWebView.frame = \(wkWebView.scrollView.frame)")
    }
    
    func runHtmlFile() -> Void {
        //
        //OC注册的方法 :用于JS调用OC
        let userContent = WKUserContentController.init()
        userContent.add(self, name: "touchMe")
        
        // js注入，注入一个alert方法，页面加载完毕弹出一个对话框。
        let javaScriptSource = "alert(\"WKUserScript注入js\");"
        let userScript = WKUserScript.init(source: javaScriptSource, injectionTime: .atDocumentEnd, forMainFrameOnly: true)// forMainFrameOnly:NO(全局窗口)，yes（只限主窗口）
        userContent.addUserScript(userScript)
        /*
         1.WKUserScript JS注入
         在WebKit框架中，我们还可以预先添加JS方法，供其他人员调用。WKUserScript就是帮助我们完成JS注入的类，它能帮助我们在页面填充前或js填充完成后调用.
         
         2.WKUserScriptInjectionTime枚举
         在WKUserScriptInjectionTime枚举中有两个状态。
         WKUserScriptInjectionTimeAtDocumentStart：js加载前执行。
         WKUserScriptInjectionTimeAtDocumentEnd：js加载后执行。
         
         3.js注入
         WKUserScript的运行需依托WKUserContentController，上面3行代码就为WKWebView注入一个js执行完毕后执行的alert方法。
         */
        
        
        let webConfig = WKWebViewConfiguration.init()
        webConfig.userContentController = userContent
        
        
        let webViewFrame = CGRect.init(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        wkWebView = WKWebView.init(frame: webViewFrame, configuration: webConfig)
        
        let wkurl :NSURL = Bundle.main.url(forResource: "HtmlTest", withExtension: "html")! as NSURL
        wkrequest = NSURLRequest.init(url: wkurl as URL)
        wkWebView.load(wkrequest as URLRequest)
        
        wkWebView.navigationDelegate = self
        wkWebView.uiDelegate = self
        
        view.addSubview(wkWebView)

    }
    
    func backAction() -> Void {
        //
        if wkWebView.canGoBack {
            wkWebView.goBack()
        }
    }
    
    func forwardAction() -> Void {
        //
        if wkWebView.canGoForward {
            //
            wkWebView.goForward()
        }
    }
    
    
    
//WKWebView KVO支持
//title页面的标题，loading是否正在加载，estimatedProgress更新加载的进度条
    func addSubKVOSever() -> Void {
        //
        progressView = UIProgressView.init()
        
        progressView.frame = CGRect.init(x:0, y:64, width:self.view.frame.width, height:30)
        progressView.progressViewStyle = .bar
        progressView.progress = 0.0
        progressView.tintColor = UIColor.red
        progressView.backgroundColor = UIColor.blue
        wkWebView.addSubview(progressView)
        
        
        wkWebView.addObserver(self, forKeyPath: "loading", options: .new, context: nil)

        wkWebView.addObserver(self, forKeyPath: "title", options: .new, context: nil)
        
        wkWebView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        //
        if keyPath == "estimatedProgress" {
            //
            progressView.alpha = 1.0
            progressView.setProgress(Float.init(wkWebView.estimatedProgress), animated: true)
            //进度条的值最大为1.0
            if wkWebView.estimatedProgress >= 1.0 {
                //
                UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveEaseInOut, animations: { 
                    //
                    self.progressView.alpha = 0.0
                }, completion: { (finished:Bool) in
                    //
                    self.progressView.progress = 0.0
                })
            }
            print("keyPath == \(keyPath)---\(progressView.frame)----\(wkWebView.estimatedProgress)")

        } else if keyPath == "loading" {
            //
            print("keyPath == \(keyPath)")
        }else if keyPath == "title"{
            //
            print("keyPath == \(keyPath)")
        }
    }
    

//WKNavigationDelegate Method--
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        //
        //self.title = wkWebView.title
        navigationItem.title = wkWebView.title
    }
//end

    
//WKUIDelegate Method--
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        //我们会发现网页上列表里的文字,包括顶栏上的文字点击了没反应,问题出在哪里呢?这是因为系统阻止了不安全的连接。怎么解决呢？我们就要用到WKUIDelegate中的createWebViewWithConfiguration()这个方法让其允许导航
        print("\(String(describing: navigationAction.targetFrame?.isMainFrame))")
        //如果目标主视图不为空,则允许导航
        if !(navigationAction.targetFrame?.isMainFrame != nil) {
            //
            wkWebView.load(navigationAction.request)
        }
        
        return nil
    }
    
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        //处理一下js的提示框事件
        let alert = UIAlertController.init(title: "alert", message: "yes,it is just a test alert!", preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "OK", style: .default, handler: { (_) in
            //
            completionHandler()
        }))
        alert.addAction(UIAlertAction.init(title: "Cancle", style: .default, handler: { (_) in
            //
            completionHandler()
        }))
                
        self.present(alert, animated: true, completion: nil)
        
        
    }
//end
    
// WKScriptMessageHandler method
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        //
        print("JS 调用了 \(message.name) 方法，传回参数 \(message.body)")
        
        touchMe()
    }
    
    
    func touchMe() -> Void {
        //OC:方法中实现通知JS，并将用户输入的信息发送给JS
        let jsStr :NSString! = NSString.init(format: "Callback('https://www.baidu.com')")
        wkWebView .evaluateJavaScript(jsStr as String, completionHandler: nil)
        
    }
    
    
    
    
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        //
        wkWebView.removeObserver(self, forKeyPath: "loading")
        wkWebView.removeObserver(self, forKeyPath: "title")
        wkWebView.removeObserver(self, forKeyPath: "estimatedProgress")
        
        wkWebView.configuration.userContentController.removeScriptMessageHandler(forName: "touchMe")
    }
    
}
