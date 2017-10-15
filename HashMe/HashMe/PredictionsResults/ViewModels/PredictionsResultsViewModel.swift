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
    
    var flowDelegate: HashTagFlowDelegate?

    var predictions: [String]?
    
    init(predictions: [String]) {
        self.predictions = predictions
    }
    
    var copyButtonTitle: String? {
        return LocalizedString.copyButtonTitle
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.predictions?.count ?? 0
    }
    
    func launchShareActivity() {
        self.flowDelegate?.launchShareSheet(withActivities: self.predictions ?? ["#HashMe"], andSubject: "This is flow Delegate")
    }
}
