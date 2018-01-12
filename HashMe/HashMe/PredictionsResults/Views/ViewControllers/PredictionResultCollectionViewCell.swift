//
//  PredictionResultCollectionViewCell.swift
//  HashMe
//
//  Created by Dheeru on 9/26/17.
//  Copyright © 2017 Dheeru. All rights reserved.
//

import UIKit

class PredictionResultCollectionViewCell: UICollectionViewCell {
    
    var isPredictionSelected: Bool? {
        didSet {
            isPredictionSelected == true ? setColors() : resetColors()
        }
    }
    
    @IBOutlet weak var predictionDisplayLabel: CustomLabel!
    @IBOutlet weak var selectionButton: UIButton!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.cornerRadius = 10.0
    }
    
    override func prepareForReuse() {
        self.predictionDisplayLabel.text = ""
    }
    
    fileprivate func setColors() {
        self.backgroundColor = UIColor.yellowCustom()
        predictionDisplayLabel.textColor = UIColor.black
    }
    
    fileprivate func resetColors() {
        self.backgroundColor = UIColor.darkGrayCustom()
        predictionDisplayLabel.textColor = UIColor.white
    }
    
    open class func reuseID() -> String {
        return "PredictionResultCollectionViewCell"
    }
}
