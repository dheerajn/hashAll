//
//  PredictionResultsPresentable.swift
//  HashMe
//
//  Created by Dheeru on 9/23/17.
//  Copyright © 2017 Dheeru. All rights reserved.
//

import Foundation
import UIKit

public protocol PredictionResultsPresentable: class {
    func showPredictionResultsView(predictions: [String])
}

public extension PredictionResultsPresentable where Self: HashTagFlowController {
    func showPredictionResultsView(predictions: [String]){
        let storyboard = UIStoryboard(name: Constants.mainStoryboardIdentifier, bundle: nil)
        let predictionResultsVc = storyboard.instantiateViewController(withIdentifier: Constants.predictionsResultsVcIdentifier) as? PredictionResultsViewController
        predictionResultsVc?.viewModel = PredictionsResultsViewModel(predictions: predictions)
       self.navigationController?.pushViewController(predictionResultsVc!, animated: true)
    }
}
