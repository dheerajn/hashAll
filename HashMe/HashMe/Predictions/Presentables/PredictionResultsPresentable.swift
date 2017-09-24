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
    func showPredictionResultsView()
}

public extension PredictionResultsPresentable where Self: HashTagFlowController {
    func showPredictionResultsView(){
        let storyboard = UIStoryboard(name: Constants.mainStoryboardIdentifier, bundle: nil)
        let predictionResultsVc = storyboard.instantiateViewController(withIdentifier: Constants.predictionsResultsVcIdentifier) as? PredictionResultsViewController
        predictionResultsVc?.viewModel = PredictionsResultsViewModel()
       self.navigationController?.pushViewController(predictionResultsVc!, animated: true)
    }
}
