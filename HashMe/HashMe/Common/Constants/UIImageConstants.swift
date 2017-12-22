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
    
    //Icons
    static var InstagramIcon: UIImage {
        guard let validInstagramImage = UIImage(named: "Instagram") else { return UIImage() }
        return validInstagramImage
    }
    
    static var MoreIcon: UIImage {
        guard let validMoreImage = UIImage(named: "more-circular-symbol") else { return UIImage() }
        return validMoreImage
    }
    
    //Navigation Button Images
    static var BackButtonImage: UIImage {
        guard let validBackButtonImage = UIImage(named: "backButtonIcon") else { return UIImage() }
        return validBackButtonImage
    }
    
    static var ShareImage: UIImage {
        guard let validShareImage = UIImage(named: "shareIcon") else { return UIImage() }
        return validShareImage
    }
    
    static var InfoImage: UIImage {
        guard let validIconImage = UIImage(named: "info") else { return UIImage() }
        return validIconImage
    }
    
    //Blured Background Images
    static var NatureImage: UIImage {
        guard let validSunLightImage = UIImage(named: "sunlight") else { return UIImage() }
        return validSunLightImage
    }
    
    static var EagleImage: UIImage {
        guard let validEagleImage = UIImage(named: "eagle") else { return UIImage() }
        return validEagleImage
    }
    
    static var SnowRiverImage: UIImage {
        guard let validSnowRiverImage = UIImage(named: "snowRiver") else { return UIImage() }
        return validSnowRiverImage
    }
}
