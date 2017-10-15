//
//  FacebookActivity.swift
//  HashMe
//
//  Created by Dheeru on 10/14/17.
//  Copyright © 2017 Dheeru. All rights reserved.
//

import Foundation
import UIKit

class FacebookActivity: UIActivity {
    
    func activityType() -> String {
        return NSStringFromClass(FacebookActivity.self)
    }

    override var activityImage: UIImage? {
        return UIImage.BatmanJokerImage
    }
    override var activityTitle: String? {
        return "Facebook"
    }
    
    override func canPerform(withActivityItems activityItems: [Any]) -> Bool {
        return true
    }
    
    override func prepare(withActivityItems activityItems: [Any]) {
        
    }
    
    override func perform() {
        
    }
}
