//
//  PredictionsViewModel.swift
//  HashMe
//
//  Created by Dheeru on 9/23/17.
//  Copyright © 2017 Dheeru. All rights reserved.
//

import UIKit
import CoreML

class PredictionsViewModel: PredictionsViewConfigurable {
    
    fileprivate var flowDelegate: HashTagFlowDelegate?
    fileprivate var predictedResults = [String]()
    
    // Deep Residual Learning for Image Recognition
    // https://arxiv.org/abs/1512.03385
    fileprivate var resnetModel = Resnet50()
    
    init(flowDelegate: HashTagFlowDelegate?) {
        self.flowDelegate = flowDelegate
    }
    
    var screenTitle: String? {
        return LocalizedString.theHashTagTitle
    }
    
    var descriptionLabelText: String? {
        return LocalizedString.hashTagDescription
    }
    
    var cameraButtonTitle: String? {
        return LocalizedString.cameraButtonTitle
    }
    
    var photoLibraryButtonTitle: String? {
        return LocalizedString.photoLibraryButtonTitle
    }
    
    var predictButtonTitle: String? {
        return LocalizedString.predictButtonTitle
    }
    
    var maxNumOfKeys: Int {
        return 7
    }
    
    func predictImage(ref: CVPixelBuffer) {
        do {
            let predictions = try resnetModel.prediction(image: ref)
            let sorted = predictions.classLabelProbs.sorted(by: { (lhs, rhs) -> Bool in
                return lhs.value > rhs.value
            })
            
            self.emptyPredictionResultsArray()
            
            for i in 0...maxNumOfKeys {
                formatPredictions(tobeFormattedString: sorted[i].key)
            }
            self.flowDelegate?.showPredictionResultsView(predictions: self.predictedResults.map({"#" + $0}))
        } catch {
            print(error)
        }
    }
    
    fileprivate func formatPredictions(tobeFormattedString: String) {
        let predictionsToBeFormatted = tobeFormattedString.characters.split{$0 == ","}.map(String.init) //{$0 == "," || $0 == ";"}
        
        for prediction in predictionsToBeFormatted {
            self.predictedResults.append(prediction)
        }
    }
    
    fileprivate func emptyPredictionResultsArray() {
        if self.predictedResults.count > 0 {
            self.predictedResults.removeAll()
        }
    }
}
