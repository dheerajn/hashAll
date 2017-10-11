//
//  UIImageConstants.swift
//  HashMe
//
//  Created by Dheeru on 10/11/17.
//  Copyright © 2017 Dheeru. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    static var BatmanJokerImage: UIImage {
        guard let validAndroidPayImage = UIImage(named: "Batman-and-the-Joker-Shows-Their-Cards") else { return UIImage() }
        return validAndroidPayImage
    }
    
    static var NatureImage: UIImage {
        guard let validAndroidPayImage = UIImage(named: "sunlight") else { return UIImage() }
        return validAndroidPayImage
    }
    
    static var EagleImage: UIImage {
        guard let validAndroidPayImage = UIImage(named: "eagle") else { return UIImage() }
        return validAndroidPayImage
    }
    
    static var SnowRiverImage: UIImage {
        guard let validAndroidPayImage = UIImage(named: "snowRiver") else { return UIImage() }
        return validAndroidPayImage
    }
}
