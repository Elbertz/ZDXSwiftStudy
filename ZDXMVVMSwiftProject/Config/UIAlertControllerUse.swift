//
//  UIAlertControllerUse.swift
//  ZDXMVVMSwiftProject
//
//  Created by Elbert on 2017/4/25.
//  Copyright © 2017年 Elbert. All rights reserved.
//

import Foundation
import UIKit

class UIAlertControllerUse: UIViewController {
    //
    override func viewDidLoad() {
        //
        super.viewDidLoad()
        
        let backButton = UIBarButtonItem.init(title: "back", style: .plain, target: self, action: Selector("backAction"))
        self.navigationItem.rightBarButtonItem = backButton
    }
    
    func backAction() -> Void {
        //
        print("UIAlertControllerUse backAction")
    }
    
    //
    func alertStyle() -> Void {
        let alert = UIAlertController.init(title: "alert", message: "yes,it is just a test alert!", preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "OK", style: .default, handler: { (_) in
            //
        }))
        alert.addAction(UIAlertAction.init(title: "Cancle", style: .default, handler: { (_) in
            //
        }))
        
        let alertSheetDestructive = UIAlertAction.init(title: "销毁", style: .destructive, handler: nil)
        alert.addAction(alertSheetDestructive)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    //
    func actionSheetStyle() -> Void {
        let alert = UIAlertController.init(title: "alert", message: "yes,it is just a test alert!", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction.init(title: "OK", style: .default, handler: { (_) in
            //
        }))
        alert.addAction(UIAlertAction.init(title: "Cancle", style: .default, handler: { (_) in
            //
        }))
        let alertSheetDestructive = UIAlertAction.init(title: "销毁", style: .destructive, handler: nil)
        alert.addAction(alertSheetDestructive)

        
        //plan1
        alert.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        
        //plan2
        //        alert.popoverPresentationController?.sourceView = self.view;
        //        alert.popoverPresentationController?.sourceRect = CGRect.init(x:100,y:100,width:1.0,height:1.0);
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    
    
}
