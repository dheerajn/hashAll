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
    
    weak var delegate: PredictionsViewDelegate?

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
    
    func predictImage(ref: CVPixelBuffer, predictionImage: UIImage) {
        do {
            let predictions = try resnetModel.prediction(image: ref)
            let sorted = predictions.classLabelProbs.sorted(by: { (lhs, rhs) -> Bool in
                return lhs.value > rhs.value
            })
            
            self.emptyPredictionResultsArray()
            
            //The following code first does take the array from 0 to 7 (inclusive) and then removes all the "," from the element and then appends it to the array
            let _ = Array(0...maxNumOfKeys).map{ sorted[$0].key.split{$0 == ","}.map(String.init).map{self.predictedResults.append("\($0)")}}
            
            self.predictedResults = self.predictedResults.map{$0.camelCaseStringLowerCase}.map({"#\($0)"}) // camelCasing and append #
            self.flowDelegate?.showPredictionResultsView(predictions: self.predictedResults, withPredictionImage: predictionImage)
            self.delegate?.removePredictionImage()
        } catch {
            print(error)
        }
    }

    fileprivate func emptyPredictionResultsArray() {
        if self.predictedResults.count > 0 {
            self.predictedResults.removeAll()
        }
    }
}
