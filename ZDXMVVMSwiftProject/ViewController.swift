//
//  ViewController.swift
//  ZDXMVVMSwiftProject
//
//  Created by Elbert on 17/4/18.
//  Copyright © 2017年 Elbert. All rights reserved.
//

import UIKit
import Foundation



let cellIdentifier = "cell"

class ViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate {
    
    var mainTableView :UITableView!
    var dataArr :NSArray?
    
    var a:String?
    
    
    override func viewWillAppear(_ animated: Bool) {
        //
        KappDelegate.isLandscape = true
        
        // 强制横屏
//        let value = UIInterfaceOrientation.landscapeLeft.rawValue
//        UIDevice.current.setValue(value, forKey: "orientation")
        
        super.viewWillAppear(animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        //
        super.viewWillDisappear(animated)
        
        //将视图还原为竖屏
        KappDelegate.isLandscape = false
        let value = UIInterfaceOrientationMask.portrait.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        
        
        self.title = "home3"
//        self.navigationBar.tintColor = UIColor.red
//        navigationBar.isHidden = false
//        setNavigationBarHidden(false, animated: true)
//        print("ffff\(navigationBar.frame)")
        self.navigationController?.navigationBar.topItem?.title = "hhhhhh"
        navigationItem.title = "home"
        
        let item = UIBarButtonItem(title: "done", style: UIBarButtonItemStyle.done, target: self, action: Selector(("done:")));
        self.navigationItem.leftBarButtonItem = item;
        
        mainTableView = UITableView.init(frame: self.view.frame, style: .plain)
        mainTableView.delegate = self;
        mainTableView.dataSource = self;
        
        self.view.addSubview(mainTableView)
        //mainTableView.value(forKeyPath: "")
        
        
        dataArr = NSArray.init()
        dataArr = ["Metal--GPU加速3D绘图","Metal--MTKView展示3D绘图","WKWebView--app内置浏览器","UICollectionView--瀑布流布局","基于UIViewController--瀑布流布局","APP内跳转至系统设置--WIFI,Bluetooth and so on","RunTime 扩展封装--ZDXRuntimeStudy","","","",]
        
    }
    
    func done(sender: UIBarButtonItem) -> Void{
        //
        print("operation is done !")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //
        return (dataArr?.count)!;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        var localCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        if localCell == nil {
            localCell = UITableViewCell.init(style: .default, reuseIdentifier: cellIdentifier)
        }
        localCell?.selectionStyle = .default
        let text :NSString = dataArr![indexPath.row] as! NSString
        
        localCell?.textLabel?.text = text as String
        
        return localCell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
        switch indexPath.row {
        case 0:
            //
            
            let testMetalVC = HelloMetal()
            self.navigationController?.pushViewController(testMetalVC, animated: true)
            break
        case 1:
            //
            
            let testMetalVC = MetalGameVIewController()
            self.navigationController?.pushViewController(testMetalVC, animated: true)
            break
        case 2:
        //
            let testWKWebVC = WKWebviewEngine()
            self.navigationController?.pushViewController(testWKWebVC, animated: true)
            
            break
        case 3:
            //
            let testWaterFlowVC = WaterFlowViewController()
            self.navigationController?.pushViewController(testWaterFlowVC, animated: true)
            
            break
        case 4:
            //
            let testWaterFlow2VC = WaterFlow2VC()
            self.navigationController?.pushViewController(testWaterFlow2VC, animated: true)
            
            break
        case 5:
            //
            let RTSCVC = RunToSystemConfig()
            self.navigationController?.pushViewController(RTSCVC, animated: true)
            
            break
        case 6:
            //
            let runtimeStudy = RuntimeStudy()
            self.navigationController?.pushViewController(runtimeStudy, animated: true)
            
            break
        default:
            break
        }
        
        
        
    }
    
    
//旋屏控制
    override var shouldAutorotate: Bool{
        return true
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return [UIInterfaceOrientationMask.portrait,.landscapeLeft]
    }
    
    /// size : 屏幕翻转后的新的尺寸;
    /// coordinator : 屏幕翻转过程中的一些信息,比如翻转时间等;
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        //
        coordinator.animate(alongsideTransition: { (context) in
            //
            let orient = UIApplication.shared.statusBarOrientation
            switch orient {
            case .portrait:
                NSLog("Portrait")
                self.mainTableView.frame = self.view.frame
                break
            case .landscapeLeft,.landscapeRight:
                NSLog("landscapeLeft")
                self.mainTableView.frame = self.view.frame
                break
            case .portraitUpsideDown:
                NSLog("portraitUpsideDown")
                break
            default:
                NSLog("unknow portrait")
                break
            }
            
            
            
            }, completion: { (context) in
            NSLog("message:rotation completed")
        })
        
        super.viewWillTransition(to: size, with: coordinator)
    }
//end

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

