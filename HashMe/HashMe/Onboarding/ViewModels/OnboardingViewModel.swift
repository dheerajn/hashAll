//
//  OnboardingViewModel.swift
//  HashMe
//
//  Created by Dheeru on 9/23/17.
//  Copyright © 2017 Dheeru. All rights reserved.
//

import Foundation

enum OnboardingAnimationDuration: Double {
    case getStartedButton = 0.25
    case tutorialLabelAnimation = 1.0
}

class OnboardingViewModel: OnboardingViewConfigurable {
    
    weak var flowDelegate: HashTagFlowDelegate?
    
    init(flowDelegate: HashTagFlowDelegate?) {
        self.flowDelegate = flowDelegate
    }
    
    var getStartedButtonTitle: String? {
        return LocalizedString.getStartedButtonTitle
    }
    
    func showPredicitonsView() {
        self.flowDelegate?.showPredictionsView()
    }
}
