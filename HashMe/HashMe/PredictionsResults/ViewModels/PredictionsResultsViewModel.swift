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

    var originalPredictions: [String]?
    var predictionImage: UIImage?
    var updatedPredicitons: [String]?

    init(predictions: [String], withPredictionImage: UIImage) {
        self.predictionImage = withPredictionImage
        self.originalPredictions = predictions
        self.updatedPredicitons = predictions
    }
    
    var copyButtonTitle: String? {
        return LocalizedString.copyButtonTitle
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.originalPredictions?.count ?? 0
    }
    
    func copyImagesToPasteboard() {
        UIPasteboard.general.strings = self.originalPredictions
    }
    
    func launchShareActivity() {
        self.flowDelegate?.launchShareSheet(withActivities: getHashTagsToBeShared(), andSubject: "#hashMe")
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
        activitiesToBeShared.add("#hashMe")
        return activitiesToBeShared
    }
}
