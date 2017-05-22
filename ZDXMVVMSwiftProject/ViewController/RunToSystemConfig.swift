//
//  RunToSystemConfig.swift
//  ZDXMVVMSwiftProject
//
//  Created by Elbert on 2017/5/8.
//  Copyright © 2017年 Elbert. All rights reserved.
//

import Foundation
import UIKit


class RunToSystemConfig: UIViewController {
    //eg:  app-Prefs:root=+跳转名称
    
    
    
    override func viewDidLoad() {
        //
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        let wifiButton :UIButton = UIButton.init(type: .system)
        wifiButton.frame = CGRect.init(x: 10, y: 70, width: 100, height: 40)
        wifiButton.setTitle("runto WiFi", for: .normal)
        wifiButton.addTarget(self, action: #selector(RunToSystemConfig.runtoWiFi), for: .touchUpInside)
        self.view.addSubview(wifiButton)
        
        
        let bluetoothButton :UIButton = UIButton.init(type: .system)
        bluetoothButton.frame = CGRect.init(x: 10, y: 120, width: 100, height: 40)
        bluetoothButton.setTitle("runto Bluetooth", for: .normal)
        bluetoothButton.addTarget(self, action: #selector(RunToSystemConfig.runtoBluetooth), for: .touchUpInside)
        self.view.addSubview(bluetoothButton)
        
    }
    
    func runtoWiFi() -> Void {
        //
        guard let url = URL.init(string: "app-Prefs:root=WIFI") else { return
        }
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.openURL(url)
        } else {
            print("\(url) is not a usefull Website")
        }
        
    }
    
    func runtoBluetooth() -> Void {
        //
        guard let url = URL.init(string: "app-Prefs:root=Bluetooth") else { return
        }
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.openURL(url)
        } else {
            print("\(url) is not a usefull Website")
        }

    }
    
    
    
}
