//
//  OptionalTypeUse.swift
//  ZDXMVVMSwiftProject
//
//  Created by Elbert on 2017/5/18.
//  Copyright © 2017年 Elbert. All rights reserved.
//

import Foundation



//自定义一个可选型的字符串合并运算符
/*
 *
 *
 @autoclosure 结构 确保仅当需要的时候（即当可选型为 nil 时）才计算右操作数。这个关键字允许你传递开销大的或具有副作用的表达式，只在极少数情况下才需要承担性能成本。我认为在此用例中这种机制不是很重要，??? 的定义镜像了 标准库中 ?? 操作符的定义。
 *
 */
infix operator ???: NilCoalescingPrecedence

public func ???<T>(optional: T?, defaultValue: @autoclosure () -> String) -> String {
    switch optional {
    case let value?: return String(describing: value)
    case nil: return defaultValue()
    }
    
//public func ???<T>(optional: T?, defaultValue: @autoclosure () -> String) -> String {
//        return optional.map { String(describing: $0) } ?? defaultValue()
//    }
    
}




class OptionalTypeUse: NSObject {
    //
    
    
    
    
    func testOptionalPrint() -> Void {
        //
        var someValue :Int? = 5
        print("The value is \(someValue)")
        //The value is Optional(5)
        someValue = nil
        print("The value is \(someValue)")
        
        
        let someValue1 :Int? = 5
        print("The value is \(String(describing:someValue1))")
    }
    
    
    func testsMakerOptional() -> Void {
        
        var someValue: Int? = 5
        print("The value is \(someValue ??? "unknown")")
        // → "The value is 5"
        someValue = nil
        print("The value is \(someValue ??? "unknown")")
    }
    
    
}
