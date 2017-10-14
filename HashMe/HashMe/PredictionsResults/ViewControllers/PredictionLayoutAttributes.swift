//
//  PredictionLayoutAttributes.swift
//  HashMe
//
//  Created by Dheeru on 10/9/17.
//  Copyright © 2017 Dheeru. All rights reserved.
//

import Foundation
import UIKit

class PredictionLayoutAttributes: UICollectionViewLayoutAttributes {
    var imageHeight: CGFloat = 0
    
    override func copy(with zone: NSZone?) -> Any {
        let copy = super.copy(with: zone) as! PredictionLayoutAttributes
        copy.imageHeight = imageHeight
        return copy
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        if let attributes = object as? PredictionLayoutAttributes {
            if attributes.imageHeight == imageHeight {
                return super.isEqual(object)
            }
        }
        return false
    }
    
}

