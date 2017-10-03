//
//  PredictionsViewPresentable.swift
//  HashMe
//
//  Created by Dheeru on 10/2/17.
//  Copyright © 2017 Dheeru. All rights reserved.
//

import Foundation
import  UIKit

public protocol PredictionsViewPresentable: class {
    func showPredictionsView()
}

public extension PredictionsViewPresentable where Self: HashTagFlowController {
    func showPredictionsView() {
        let storyboard = UIStoryboard(name: Constants.mainStoryboardIdentifier, bundle: nil)
        let viewControllerToBeShown: UIViewController?
        
        let hashTagVc = storyboard.instantiateViewController(withIdentifier: Constants.hashtagsVcIdentifier) as? PredictionsViewController
        hashTagVc?.flowDelegate = self
        hashTagVc?.viewModel = PredictionsViewModel(flowDelegate: self)
        
        viewControllerToBeShown = hashTagVc
        
        DispatchQueue.main.asyncAfter(deadline: TimeInterval.convertToDispatchTimeT(1)) {
            self.navigationController?.pushViewController(viewControllerToBeShown!, animated: true)
        }
    }
}
