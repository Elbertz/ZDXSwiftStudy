//
//  WaterFlowVCModel.swift
//  ZDXMVVMSwiftProject
//
//  Created by Elbert on 2017/4/26.
//  Copyright © 2017年 Elbert. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    //
    class func randomValue() -> CGFloat {
        return CGFloat(arc4random_uniform(256))/255
    }
    
    public class func randomColor() -> UIColor {
        return UIColor.init(red: randomValue(), green: randomValue(), blue: randomValue(), alpha: 1)
    }
}

protocol WaterFlowViewLayoutDelegate: NSObjectProtocol {
    //
    //width是瀑布流每列的宽度
    func waterFlowViewLayout(waterFlowViewLayout:WaterFlowViewLayout,heightForWidth:CGFloat,atIndexPath:NSIndexPath) -> CGFloat
}


class WaterFlowViewLayout: UICollectionViewLayout {
    //
    weak var delegate :WaterFlowViewLayoutDelegate?
    
    //所有cell 的布局属性
    var layoutAttributes = [UICollectionViewLayoutAttributes]()
    
    //使用一个字典记录每列的最大Y值
    var maxYDict = [Int:CGFloat]()
    
    //瀑布流四周的间距
    static var Margin:CGFloat = 8
    var sectionInset = UIEdgeInsets.init(top: Margin, left: Margin, bottom: Margin, right: Margin)
    
    //列间距
    var columnMargin:CGFloat = Margin
    
    //行间距
    var rowMargin:CGFloat = Margin
    
    //瀑布流列数
    var column = 4
    
    var maxY:CGFloat = 0.0
    
    var columnWidth:CGFloat = 0.0
    
    //prepareLayout会在调用collectionView.reloadData() 之前
    //对UICollectionViewLayoutAttributes 进行设置
    override func prepare() {
        //
        //设置布局
        //需要清空字典里面的值
        for key in 0..<column{
            maxYDict[key] = 0
        }
        
        //清空之前的布局属性
        layoutAttributes.removeAll()
        
        //清空最大列的Y值
        maxY = 0
        
        //清空列宽
        columnWidth = 0
        
        //计算每列的宽度，需要在布局之前算好
        //每列的宽度=（主屏幕宽度-左边距-右边距-列数-1倍列间距）／列数
        columnWidth = (UIScreen.main.bounds.width - sectionInset.left - sectionInset.right - (CGFloat(column)-1)*columnMargin) / (CGFloat(column))
        
        //section=0时返回items的个数，（！=0也就是默认collectionView的section只有1个）也就是section为空时返回0
        let number = collectionView?.numberOfItems(inSection: 0) ?? 0
        for i in 0..<number{
            //布局每一个cell的frame
            let itemLayoutAttributes = layoutAttributesForItem(at: IndexPath(item: i, section: 0))!
            layoutAttributes.append(itemLayoutAttributes)
            
        }
        
        calcmaxY()

    }
    
    func calcmaxY() -> Void {
        //获取最大这一列的Y
        //默认第0列最长
        var maxYColumn = 0
        
        //for 循环比较，获取最长的这列
        for (key,value) in maxYDict {
            //
            if value > maxYDict[maxYColumn]! {
                //key这列的Y值是最大的
                maxYColumn = key
            }
        }
        
        //获取到Y值最大的这一列
        maxY = maxYDict[maxYColumn]! + sectionInset.bottom
    }
        //返回collectionViewContentSize 大小-- 重载父类方法 --
    override var collectionViewContentSize: CGSize{
            return CGSize.init(width: UIScreen.main.bounds.width, height: maxY)
        }
    
        
        // 返回每一个cell的布局属性(layoutAttributes)
        //  UICollectionViewLayoutAttributes: 1.cell的frame 2.indexPath
        override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
            //
            assert(delegate != nil,"瀑布流必须实现代理来返回cell的高度")
            
            let height = delegate!.waterFlowViewLayout(waterFlowViewLayout: self, heightForWidth: columnWidth, atIndexPath: indexPath as NSIndexPath)
            
            // 找到最短的那一列,去maxYDict字典中找
            
            // 最短的这一列
            var minYColumn = 0
            
            for (key,value) in maxYDict {
                //
                if value < maxYDict[minYColumn]! {
                    minYColumn = key
                }
            }
            
            //minYColumn 就是短的那一列
            let x = sectionInset.left + CGFloat(minYColumn) * (columnWidth + columnMargin)
            //最短这列的Y值 + 行间距
            let y = maxYDict[minYColumn]! + rowMargin
            //设置cell的frame
            let  frame = CGRect.init(x: x, y: y, width: columnWidth, height: height)
            
            //更新最短这列的最大Y值
            maxYDict[minYColumn] = frame.maxY
            
            //创建每个cell对应的布局属性
            let minLayoutAtttibutes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            minLayoutAtttibutes.frame = frame
            return minLayoutAtttibutes
            
        }
        
        override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]?{
            return layoutAttributes
        }
        
}
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    



