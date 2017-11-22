//
//  UICollectionViewExtension.swift
//  HashMe
//
//  Created by Dheeru on 10/25/17.
//  Copyright © 2017 Dheeru. All rights reserved.
//

import Foundation
import UIKit

public extension UICollectionViewCell {
    func scaleDownForAnimation() {
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 5, options: [], animations: {
            self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }, completion: nil)
    }
    
    func scaleToIdentityWith3DAnimation() {
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 5, options: [], animations: {
            self.transform = CGAffineTransform(scaleX: 1, y: 1)
        }, completion: nil)
    }
}
