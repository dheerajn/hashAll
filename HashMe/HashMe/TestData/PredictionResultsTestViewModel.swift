//
//  PredictionResultsTestViewModel.swift
//  HashMe
//
//  Created by Dheeru on 2/9/18.
//  Copyright © 2018 Dheeru. All rights reserved.
//

import UIKit

class PredictionResultsTestViewModel: PredictionResultsViewConfigurable {
    
    weak var flowDelegate: HashTagFlowDelegate?
    weak var delegate: PredictionResultsViewModelDelegate?

    var originalPredictions: [String]?
    var predictionImage: UIImage?
    var updatedPredicitons: [String]?
    
    init(predictions: [String], withPredictionImage: UIImage) {
        self.predictionImage = withPredictionImage
        self.originalPredictions = predictions
        self.updatedPredicitons = []
    }
    
    var copyButtonTitle: String? {
        return "test copy button"
    }
    
    var selectAllButtonTitle: String? {
        return "test select all"
    }
    
    var copiedLabelTitle: String? {
        return "test copied"
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func copyHashTagsToPasteboard() {
        UIPasteboard.general.strings = self.updatedPredicitons
    }
    
    func selectAllButtonTapped() {
        self.updatedPredicitons = self.originalPredictions
    }
    
    func deselectAllButtonTapped() {
        self.updatedPredicitons = []
    }
    
    func launchShareActivity(withFrame: CGRect) {
        self.flowDelegate?.launchShareSheet(withActivities: getHashTagsToBeShared(), andSubject: "#\(LocalizedString.appNameCamelCased)App", withFrame: withFrame)
    }
    
    func updatePredictionsArray(forHashTag tag: String) {
        guard let validUpdatedPredictions = self.updatedPredicitons else { return }
        if validUpdatedPredictions.contains(tag) {
            self.updatedPredicitons = validUpdatedPredictions.filter{$0 != tag}
        } else {
            self.updatedPredicitons?.append(tag)
        }
    }
    
    fileprivate func getHashTagsToBeShared() -> NSMutableArray {
        let activitiesToBeShared = NSMutableArray()
        activitiesToBeShared.add(self.predictionImage ?? UIImage())
        for activity in self.updatedPredicitons ?? [] {
            activitiesToBeShared.add(activity)
        }
        let appName = Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String ?? "\(LocalizedString.appNameCamelCased)App"
        activitiesToBeShared.add("#\(appName.camelCaseStringLowerCase)")
        return activitiesToBeShared
    }
    
    func askToCopyTagsAlert() {
        
    }
    
    func showInstagramAlertIssue() {
        
    }
}

