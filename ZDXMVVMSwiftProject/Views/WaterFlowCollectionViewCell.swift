//
//  WaterFlowCollectionViewCell.swift
//  ZDXMVVMSwiftProject
//
//  Created by Elbert on 2017/4/28.
//  Copyright © 2017年 Elbert. All rights reserved.
//

import Foundation
import UIKit

class WaterFlowCollectionViewCell: UICollectionViewCell {
    //
    public var backButton :UIButton!
    var iamgeView :UIImageView!
    var detailLabel :UILabel!
    var nameLabel :UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        print("\(frame)----\(self.contentView.frame)")
        backButton = UIButton.init(frame: frame)
        backButton.addTarget(self, action: #selector(WaterFlowCollectionViewCell.handleBackButtonAction(sender:)), for: .touchUpInside)
        //contentView.addSubview(backButton)
        
        
        let detailLabel_Width = frame.size.width*0.6
        let detailLabel_Height :CGFloat = 10.0
        let detailLabel_X = backButton.frame.size.width-detailLabel_Width
        let detailLabel_Y = backButton.frame.size.height - detailLabel_Height
        detailLabel = UILabel.init(frame: CGRect.init(x: detailLabel_X, y: detailLabel_Y, width: detailLabel_Width, height: detailLabel_Height))
        
        detailLabel.backgroundColor = UIColor.darkGray
        detailLabel.text = "\(detailLabel_Height)"
        detailLabel.font = UIFont.systemFont(ofSize: 8)
        backButton.addSubview(detailLabel)
        
        //self.contentView.addSubview(backButton)
        //backgroundView = backButton
        
        /*
         *********
         
         在layout的绘制下，子控件也被绘制，但是会出现偏差--这是个问题
         *********
         */
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func handleBackButtonAction(sender:UIButton){
        
    }
    
    override func reloadInputViews() {
        //
        super.reloadInputViews()
    }
    
    
    
    
    
}
