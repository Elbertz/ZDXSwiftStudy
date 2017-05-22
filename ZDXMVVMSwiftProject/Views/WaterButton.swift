//
//  WaterButton.swift
//  ZDXMVVMSwiftProject
//
//  Created by Elbert on 2017/5/2.
//  Copyright © 2017年 Elbert. All rights reserved.
//

import Foundation
import UIKit

//实现点击cell得到大图
class WaterButton: UIButton {
    private var wImageView :UIImageView!
    
    var wImage :UIImage!{
        didSet{
            wImageView.image = wImage
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        wImageView = UIImageView(frame: self.bounds)
        addSubview(wImageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        //监听因为主控件WaterButton的frame变化 导致子控件frame的调整
        super.layoutSubviews()
        wImageView.frame = bounds
    }
    
}





