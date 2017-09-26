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
        return "CAMERA"
    }
    
    var photoLibraryButtonTitle: String? {
        return "PHOTO LIBRARY"
    }
    
    var predictButtonTitle: String? {
        return "GENERATE HASHTAGS"
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
                self.predictedResults.append(sorted[i].key)
            }
            self.flowDelegate?.showPredictionResultsView(predictions: self.predictedResults)
        } catch {
            print(error)
        }
    }
}
