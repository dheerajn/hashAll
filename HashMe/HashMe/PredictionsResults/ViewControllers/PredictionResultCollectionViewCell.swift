//
//  PredictionResultCollectionViewCell.swift
//  HashMe
//
//  Created by Dheeru on 9/26/17.
//  Copyright © 2017 Dheeru. All rights reserved.
//

import UIKit

class PredictionResultCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var predictionDisplayLabel: CustomLabel!
    
    @IBOutlet weak var selectionButton: UIButton!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open class func reuseID() -> String {
        return "PredictionResultCollectionViewCell"
    }
}
