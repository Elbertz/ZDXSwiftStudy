//
//  RuntimeStudy.swift
//  ZDXMVVMSwiftProject
//
//  Created by Elbert on 2017/5/8.
//  Copyright © 2017年 Elbert. All rights reserved.
//

import Foundation
import UIKit

// MARK: - RunTime
extension NSObject{
    
    /**
     *   获取所有的方法和属性
     *   参数： 当前类
     */
    func mg_GetMethodAndPropertiesFromClass(cls:AnyClass) {
        //
        debugPrint("方法========================================================")
        var methodNum :UInt32 = 0
        let methods = class_copyMethodList(cls, &methodNum)
        for index in 0..<numericCast(methodNum) {
            //
            let method :Method = methods![index]!
            debugPrint("m_name: \(method_getName(method)!)")
            
        }
        print("functionName=\(#function)--line=\(#line)--file=\(#file)--column=\(#column)")
        
        debugPrint("属性=========================================================")
        var proNum :UInt32 = 0
        let properties = class_copyPropertyList(cls, &proNum)
        for index in 0..<Int(proNum) {
            //
            let prop: objc_property_t = properties![index]!
            debugPrint("p_name: \(String(utf8String: property_getName(prop))!)")
            
        }
        
        
        
        debugPrint("成员变量======================================================")
        var ivarNum: UInt32 = 0
        let ivars = class_copyIvarList(cls, &ivarNum)
        for index in 0..<numericCast(ivarNum) {
            let ivar: objc_property_t = ivars![index]!
            let name = ivar_getName(ivar)
            debugPrint("ivar_name: \(String(cString: name!))")
        }
        
        
    }
    
    
    /**
     *  交换方法
     *  参数： 当前类 ，原方法   要交换的方法
     */
    class func mg_SwitchMethod(cls:AnyClass,originalSelector:Selector,swizzledSelector:Selector) {
        let originalMethod = class_getInstanceMethod(cls, originalSelector)
        let swizzledmethod = class_getInstanceMethod(cls, swizzledSelector)
        
        let didAddMethod = class_addMethod(cls, originalSelector,method_getImplementation(swizzledmethod), method_getTypeEncoding(swizzledmethod))
        
        if didAddMethod {
            class_replaceMethod(cls, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
        } else {
            method_exchangeImplementations(originalMethod, swizzledmethod)
        }
        
        
    }
    
    
    
    
    
    
}


class RuntimeStudy: UIViewController {
    //
    let button1 :UIButton? = nil
    
    
    
    override func viewDidLoad() {
        //
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        getSystemAllFontName()
        
    }
    
    
    func getSystemAllFontName() -> Void {
        //
        for familyName in UIFont.familyNames {
            //
            print("\n\nFamily name: \(familyName)")
            for fontName in UIFont.fontNames(forFamilyName: familyName) {
                //
                print("Font name: \(fontName)")
            }
        }
    }
    
    
    
    func constraintView() -> Void {
        //禁用autoresizing(重要)
        //给需要设置约束的视图禁用autoresizing，禁用父视图autoresizing对子控件无效
        
        
        //方法1：代码添加autolayout约束
        // 说明
        /*
         constraintWithItem:需要设置约束的view
         attribute:需要设置约束的位置
         relatedBy:约束的条件
         toItem:约束依赖目标
         attribute:依赖目标约束位置
         multiplier:配置系数
         constant:额外需要添加的长度
         */
        /*
         计算公式:redView.attribute = self.view.attribute * multiplier + constant;
         其中:＝符号取决于relatedBy:参数
         typedef NS_ENUM(NSInteger, NSLayoutRelation) {
         NSLayoutRelationLessThanOrEqual = -1,   小于等于
         NSLayoutRelationEqual = 0,              等于
         NSLayoutRelationGreaterThanOrEqual = 1, 大于等于
         };
         */
        button1?.translatesAutoresizingMaskIntoConstraints = false
        let leftCon = NSLayoutConstraint(item: button1, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.left, multiplier: 1.0, constant: 0)
        let rightCon = NSLayoutConstraint(item: button1, attribute: .right, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: .right, multiplier: 1.0, constant: 0)
        let topCon = NSLayoutConstraint(item: button1, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 0)
        let bottomCon = NSLayoutConstraint(item: button1, attribute: .bottom, relatedBy: .equal
            , toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: 0)
        self.view.addConstraints([leftCon,rightCon,topCon,bottomCon])
        
        
        //方法2：添加约束 VFL格式
        // 说明
        /*VFL格式说明
         功能　　　　　　　　表达式
         水平方向  　　　　　 H:
         垂直方向  　　　　　 V:
         Views　　　　　　　　[view]
         SuperView　　　　　 |
         关系　　　　　　　　　>=,==,<=
         空间,间隙　　　　　　　-
         优先级　　　　　　　　@value
         -----------------------------------------------------
         VisualFormat: VFL语句
         options: 对齐方式等,可以选择居中等
         metrics: VFL语句中使用到的一些变量
         views: VFL语句中使用到的一些控件
         */
        
        button1?.translatesAutoresizingMaskIntoConstraints = false
        var cons = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[tableView]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["tableView": button1])
        cons += NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[tableView]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["tableView": button1])
        view.addConstraints(cons)
        
        /*
         *
         *
         eg1： "V:|-20-[redView(==50)]"
         
         解释：redView(==50)是什么意思？V是代表垂直方向，垂直方向也就是高度，说明redView他的高度是50，同理如果是H开头呢，就是代表宽度 。-20-又是什么意思呢？距离父控件上边为20。
         eg2："V:[redView]-20-[blueView(==50)]"
         
         解释：同理blueView他的高度是50，V是代表垂直方向，而且blueView距离redView垂直距离为20
         
         eg3:
         let layout_frameView = ["frameView":frameView,"superView":self.view]
         var frameView_constraints = NSLayoutConstraint.constraintsWithVisualFormat("H:[frameView(300.)]-(<=1)-[superView]", options: NSLayoutFormatOptions.AlignAllCenterY, metrics: nil, views: layout_frameView)
         frameView_constraints = NSLayoutConstraint.constraintsWithVisualFormat("V:[frameView(200.0)]-(<=1)-[superView]", options: NSLayoutFormatOptions.AlignAllCenterX, metrics: nil, views: layout_frameView)
         view.addConstraints(frameView_constraints)
         
         解释：frameView宽度300和高度为200并且居中显示
         
         *
         *
         */
        
        
    }
 
 
    
}



















