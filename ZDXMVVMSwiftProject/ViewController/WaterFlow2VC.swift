//
//  WaterFlow2VC.swift
//  ZDXMVVMSwiftProject
//
//  Created by Elbert on 2017/5/2.
//  Copyright © 2017年 Elbert. All rights reserved.
//

import Foundation
import UIKit

class WaterFlow2VC: UIViewController {
    //
    var width: CGFloat!
    var images: Array<UIImage>!
    var collectionView:UICollectionView!
    var maskView: UIView!
    var cellRect: CGRect!
    var changeRect: CGRect!
    //MARK: --life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        waterfallCollectionView()
    }
    private func waterfallCollectionView() {
        width = (view.bounds.size.width - 20)/3
        let layout = WaterCollectionViewLayout()
        images = []
        
        for i in 1..<17 {
            let imagesPath :String = Bundle.main.path(forResource: String.init(format: "%d", i), ofType: "png")!
            print("\(imagesPath)")
            
            let image :UIImage = UIImage(named: imagesPath)!
            images.append(image)
        }
        layout.setSize = {_ in
            return self.images
        }
        
        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "newCell")
        collectionView.backgroundColor = UIColor.white
        collectionView.alwaysBounceVertical = true
        
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        
    }
    
    func showPic(btn:UIButton){
        UIView.animate(withDuration: 1, animations: {
            btn.frame = self.cellRect
        }) { (finish) in
            btn.removeFromSuperview()
            self.maskView.removeFromSuperview()
            self.maskView = nil
            self.cellRect = nil
        }
    }
}

extension WaterFlow2VC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    //MARK: --UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newCell", for: indexPath as IndexPath)
        let imageView = UIImageView(frame: cell.bounds)
        imageView.image = images[indexPath.row]
        let bgView = UIView(frame:cell.bounds)
        bgView.addSubview(imageView)
        cell.backgroundView = bgView
        
        
        let detailLabel_Width = cell.frame.size.width*0.6
        let detailLabel_Height :CGFloat = 10.0
        let detailLabel_X = cell.frame.size.width-detailLabel_Width
        let detailLabel_Y = cell.frame.size.height - detailLabel_Height
        let detailLabel :UILabel = UILabel.init(frame: CGRect.init(x: detailLabel_X, y: detailLabel_Y, width: detailLabel_Width, height: detailLabel_Height))
        
        detailLabel.backgroundColor = UIColor.darkGray
        detailLabel.text = "care at next"
        detailLabel.font = UIFont.systemFont(ofSize: 8)
        bgView.addSubview(detailLabel)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        maskView = UIView.init(frame: view.bounds)
        maskView.backgroundColor = UIColor.black
        maskView.alpha = 0.5
        view.addSubview(maskView)
        
        //cell在veiw的位置
        cellRect = cell!.convert(cell!.bounds, to: view)
        let btn = WaterButton.init(frame: cellRect)
        let img = images[indexPath.row]
        btn.wImage = img
        btn.addTarget(self, action: #selector(showPic(btn:)), for: UIControlEvents.touchUpInside)
        view.addSubview(btn)
        //图片长宽的比例与屏幕长宽的比例的对比
        var changeH:CGFloat
        var changeW:CGFloat
        if img.size.width/img.size.height >= view.frame.size.width/view.frame.size.height{
            //对比图片实际宽与屏幕宽
            if img.size.width>view.frame.size.width {
                changeH = img.size.height*view.frame.size.width/img.size.width
                changeRect = CGRect(x: 0, y: (view.frame.size.height-changeH)/2, width:view.frame.size.width, height: changeH)
            }else{
                changeRect = CGRect(x: (view.frame.size.width-img.size.width)/2, y: (view.frame.size.height-img.size.height)/2, width: img.size.width,height: img.size.height)
            }
        }else{
            if img.size.height>view.frame.size.height {
                changeW = img.size.width*view.frame.size.height/img.size.height
                changeRect = CGRect(x: (view.frame.size.width-changeW)/2, y: 0, width: changeW, height: view.frame.size.height)
            }else{
                changeRect = CGRect(x: (view.frame.size.width-img.size.width)/2, y: (view.frame.size.height-img.size.height)/2, width: img.size.width,height: img.size.height)
            }
        }
        
        UIView.animate(withDuration: 1, animations: {
            btn.frame = self.changeRect
            btn.backgroundColor = UIColor.red
        })
        
    }
}
