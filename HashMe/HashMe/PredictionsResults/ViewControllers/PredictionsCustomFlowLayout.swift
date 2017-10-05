//
//  PredictionsCustomFlowLayout.swift
//  HashMe
//
//  Created by Dheeru on 10/4/17.
//  Copyright © 2017 Dheeru. All rights reserved.
//

import Foundation
import UIKit

protocol PredictionsCustomFlowLayoutDelegate: class {
    func collectionView(_ collectionView: UICollectionView, heightForCellAt indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat
}

class PredictionsCustomFlowLayout: UICollectionViewLayout {
    
    weak var delegate: PredictionsCustomFlowLayoutDelegate!
    
    var numberOfColumns = 2
    
    private var cache = [UICollectionViewLayoutAttributes]()
    
    private var contentHeight: CGFloat  = 0.0
    
    private var contentWidth: CGFloat {
        let insets = collectionView!.contentInset
        return collectionView!.bounds.width - (insets.left + insets.right)
    }
}

extension PredictionsCustomFlowLayout {
    override func prepare() {
        // Reset
        cache = [UICollectionViewLayoutAttributes]()
        contentHeight = 0
        
        let columnWidth = contentWidth / CGFloat(numberOfColumns)
        
        // xOffset tracks for each column. This is fixed, unlike yOffset.
        var xOffset = [CGFloat]()
        for column in 0 ..< numberOfColumns {
            xOffset.append(CGFloat(column) * columnWidth )
        }
        
        // yOffset tracks the last y-offset in each column
        var yOffset = [CGFloat](repeating: 0, count: numberOfColumns)
        
        // Start calculating for each item
        for item in 0 ..< collectionView!.numberOfItems(inSection: 0) {
            
            let indexPath = IndexPath(item: item, section: 0)
            let cellPadding: CGFloat = 10.0
            let width = columnWidth - cellPadding * 2
            let cellHeight = delegate.collectionView(collectionView!, heightForCellAt: indexPath, withWidth: width)
            let height = cellHeight + 2*cellPadding
            
            // Find the shortest column to place this item
            var shortestColumn = 0
            if let minYOffset = yOffset.min() {
                shortestColumn = yOffset.index(of: minYOffset) ?? 0
            }
            
            let frame = CGRect(x: xOffset[shortestColumn], y: yOffset[shortestColumn], width: columnWidth, height: height)
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
            
            // Create our attributes
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            cache.append(attributes)
            
            // Updates
            contentHeight = max(contentHeight, frame.maxY)
            
            yOffset[shortestColumn] = yOffset[shortestColumn] + height
        }
    }
}

extension PredictionsCustomFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                layoutAttributes.append(attributes)
            }
        }
        return layoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache.first { attributes -> Bool in
            return attributes.indexPath == indexPath
        }
    }
}
