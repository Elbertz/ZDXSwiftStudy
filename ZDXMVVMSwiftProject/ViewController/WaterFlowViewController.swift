//
//  WaterFlowViewController.swift
//  ZDXMVVMSwiftProject
//
//  Created by Elbert on 2017/4/26.
//  Copyright © 2017年 Elbert. All rights reserved.
//

import Foundation
import UIKit


class WaterFlowViewController: UICollectionViewController,WaterFlowViewLayoutDelegate {
    //
    let reuseIdentifier = "ReuseIdentifier"
    
    let layout = WaterFlowViewLayout()
    
    init() {
        //
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        //
        super.viewDidLoad()
        
        collectionView?.backgroundColor = UIColor.white
        
        //factory1
//        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        //factory2
        collectionView?.register(WaterFlowCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        
        layout.delegate = self
        
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //
        return 200
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        cell.backgroundColor = UIColor.randomColor()
        
        let detailLabel_Width = cell.frame.size.width*0.6
        let detailLabel_Height :CGFloat = 10.0
        let detailLabel_X = cell.frame.size.width-detailLabel_Width
        let detailLabel_Y = cell.frame.size.height - detailLabel_Height
        let detailLabel = UILabel.init(frame: CGRect.init(x: detailLabel_X, y: detailLabel_Y, width: detailLabel_Width, height: detailLabel_Height))
        
        detailLabel.backgroundColor = UIColor.darkGray
        detailLabel.text = "care at next"
        detailLabel.font = UIFont.systemFont(ofSize: 8)
        //cell.addSubview(detailLabel)
        
        //cell.backgroundView = detailLabel
        
        return cell
        
    }
    
    
//WaterFlowViewLayoutDelegate methods
    func waterFlowViewLayout(waterFlowViewLayout: WaterFlowViewLayout, heightForWidth: CGFloat, atIndexPath: NSIndexPath) -> CGFloat {
        //
        return CGFloat(100 + arc4random_uniform(50))
    }
    
}
