//
//  PredictionsResultsViewModel.swift
//  HashMe
//
//  Created by Dheeru on 9/23/17.
//  Copyright © 2017 Dheeru. All rights reserved.
//

import Foundation
import UIKit

class PredictionsResultsViewModel: PredictionResultsViewConfigurable {
    
    var predictions: [String]?
    
    init(predictions: [String]) {
        self.predictions = predictions
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.predictions?.count ?? 0
    }
}
