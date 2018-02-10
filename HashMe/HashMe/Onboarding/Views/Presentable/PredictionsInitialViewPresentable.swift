//
//  PredictionsInitialViewPresentable.swift
//  HashMe
//
//  Created by Dheeru on 10/19/17.
//  Copyright © 2017 Dheeru. All rights reserved.
//

import Foundation
import  UIKit

public protocol PredictionsInitialViewPresentable: class {
    func showPredictionsView()
}

public extension PredictionsInitialViewPresentable where Self: HashTagFlowController {
    func showPredictionsView() {
        let storyboard = UIStoryboard(name: Constants.mainStoryboardIdentifier, bundle: nil)
        let hashTagVc = storyboard.instantiateViewController(withIdentifier: Constants.predictionsVcIdentifier) as? PredictionsViewController
        hashTagVc?.flowDelegate = self
        hashTagVc?.viewModel = PredictionsViewModel(flowDelegate: self)
        // if test
        //hashTagVc?.viewModel = PredictionsTestViewModel(flowDelegate: nil)
        
        self.pushViewControllerWithAnimation(hashTagVc!, withAnimationType: .fade)
    }
}

