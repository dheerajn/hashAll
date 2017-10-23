//
//  PredictionsLayout.swift
//  HashMe
//
//  Created by Dheeru on 10/9/17.
//  Copyright © 2017 Dheeru. All rights reserved.
//

import Foundation
import UIKit

protocol PredictionLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, heightForImageAtIndexPath indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat
    
//    func collectionView(_ collectionView: UICollectionView, heightForDescriptionAtIndexPath indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat
    func collectionView(_ collectionView: UICollectionView, widthForDescriptionAtIndexPath indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat
}

class PredictionViewLayout: UICollectionViewLayout {
    
    var delegate: PredictionLayoutDelegate!
    var numberOfColumns = 0
    var cellPadding: CGFloat = 0
    
    var cache = [PredictionLayoutAttributes]()
    fileprivate var contentHeight: CGFloat = 0
    fileprivate var width: CGFloat {
        get {
            let insets = collectionView!.contentInset
            return collectionView!.bounds.width - (insets.left + insets.right)
        }
    }
    
    override class var layoutAttributesClass : AnyClass {
        return PredictionLayoutAttributes.self
    }
    
    override var collectionViewContentSize : CGSize {
        return CGSize(width: width, height: contentHeight)
    }
    
    override func prepare() {
        if cache.isEmpty {
            let columnWidth = width / CGFloat(numberOfColumns)
            
            var xOffsets = [CGFloat]()
            for column in 0..<numberOfColumns {
                xOffsets.append(CGFloat(column) * columnWidth)
            }
            
            var yOffsets = [CGFloat](repeating: 0, count: numberOfColumns)
            
            var column = 0
            var itemcount = 0
            var widthCache = [Int:CGFloat]()
            
            for item in 0..<collectionView!.numberOfItems(inSection: 0) {
                let indexPath = IndexPath(item: item, section: 0)
                let width = columnWidth - (cellPadding * 2)
                let imageHeight = delegate.collectionView(collectionView!, heightForImageAtIndexPath: indexPath, withWidth: width)
                //                let descriptionHeight = delegate.collectionView(collectionView!, heightForDescriptionAtIndexPath: indexPath, withWidth: width)
                let descriptionWidth = delegate.collectionView(collectionView!, widthForDescriptionAtIndexPath: indexPath, withWidth: width)
                
                let height = cellPadding + imageHeight + 50 + cellPadding
                let testwidth = cellPadding + imageHeight + descriptionWidth + cellPadding
                var xOffset : CGFloat = 0;
                if (itemcount%numberOfColumns != 0) {
                    let previousCellIndexPath = itemcount - 1
                    let previousCellWidth = widthCache[previousCellIndexPath]
                    xOffset = previousCellWidth!
                } else {
                    xOffset = xOffsets[column]
                }
                let frame = CGRect(x: xOffset , y: yOffsets[column], width: testwidth, height: 50)
                let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
                let attributes = PredictionLayoutAttributes(forCellWith: indexPath)
                attributes.frame = insetFrame
                attributes.imageHeight = imageHeight
                cache.append(attributes)
                contentHeight = max(contentHeight, frame.maxY)
                yOffsets[column] = yOffsets[column] + height
                column = column >= (numberOfColumns - 1) ? 0 : column + 1
                widthCache[itemcount] = xOffset + testwidth
                itemcount = itemcount + 1
                
            }
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                layoutAttributes.append(attributes)
            }
        }
        return layoutAttributes
    }
}


