//
//  EncodeForString.swift
//  ZDXMVVMSwiftProject
//
//  Created by Elbert on 2017/5/10.
//  Copyright © 2017年 Elbert. All rights reserved.
//

import Foundation


extension String{
    // MARK: - encoding 系统API
    /*
     URLFragmentAllowedCharacterSet  "#%<>[\]^`{|}
     URLHostAllowedCharacterSet      "#%/<>?@\^`{|}
     URLPasswordAllowedCharacterSet  "#%/:<>?@[\]^`{|}
     URLPathAllowedCharacterSet      "#%;<>?[\]^`{|}
     URLQueryAllowedCharacterSet     "#%<>[\]^`{|}
     URLUserAllowedCharacterSet      "#%/:<>?@[\]^`
     */
    /**   这个方法没有多大用，系统API已经提供了很多方法给我们如上
     *  URL 编码
     *   return 编码字符串
     */
    func encodeEscapesURL(value:String) -> String {
        let str:String = value
        let originalString = str as CFString
        let charactersToBeEscaped = "!*'();:@&=+$,/?%#[]" as CFString //":/?&=;+!@#$()',*"    //转义符号
        //let charactersToLeaveUnescaped = "[]." as CFStringRef  //保留的符号
        
        //Use [NSString stringByAddingPercentEncodingWithAllowedCharacters:] instead
        let result = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, originalString, nil, charactersToBeEscaped, CFStringConvertNSStringEncodingToEncoding(String.Encoding.utf8.rawValue)) as NSString
        
        
        return result as String
        
    }
    
    
    /**
     *  URL 解码
     *   return 解码字符串
     */
    func stringByURLDecode() -> String {
        //
        if self.removingPercentEncoding != nil {
            return self.removingPercentEncoding!
        } else {
            let en :CFStringEncoding = CFStringConvertNSStringEncodingToEncoding(String.Encoding.utf8.rawValue)
            var decoded :String = self.replacingOccurrences(of: "+", with: " ")
            decoded = (CFURLCreateStringByReplacingPercentEscapesUsingEncoding(nil, decoded as CFString, nil, en) as String)
            
            return decoded
        }
    }
    
    
}

class EncodeForString: NSObject {
    //
    
    func testEncodeURL() -> Void {
        //
        "http://baidu.com".encodeEscapesURL(value: "http://你好baidu.com")
        let urlCode = "http://你好baidu.com".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlPasswordAllowed)
        urlCode?.stringByURLDecode()
    }
}


