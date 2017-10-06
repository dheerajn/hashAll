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
        return "Hash Me title"
    }
    
    var cameraButtonTitle: String? {
        return NSLocalizedString("CameraButtonTitle", comment: "Title for camera button")
    }
    
    var photoLibraryButtonTitle: String? {
        return NSLocalizedString("PhotoLibraryButtonTitle", comment: "Title for photo library button")
    }
    
    var predictButtonTitle: String? {
        return NSLocalizedString("GetHashTagsButtonTitle", comment: "Title for get hashtags button")
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
            for i in 0...maxNumOfKeys {
                formatPredictions(tobeFormattedString: sorted[i].key)
            }
            self.flowDelegate?.showPredictionResultsView(predictions: self.predictedResults)
        } catch {
            print(error)
        }
    }
    
    private func formatPredictions(tobeFormattedString: String) {
        let predictionsToBeFormatted = tobeFormattedString.characters.split{$0 == ","}.map(String.init) //{$0 == "," || $0 == ";"}
        
        for prediction in predictionsToBeFormatted {
            self.predictedResults.append(prediction)
        }
    }
}
