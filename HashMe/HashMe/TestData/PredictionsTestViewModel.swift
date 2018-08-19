//
//  PredictionsTestViewModel.swift
//  HashMe
//
//  Created by Dheeru on 2/9/18.
//  Copyright © 2018 Dheeru. All rights reserved.
//

import Foundation
import UIKit
import CoreML

class PredictionsTestViewModel: PredictionsViewConfigurable {
    
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
        return "test title"
    }
    
    var descriptionLabelText: String? {
        return "test description"
    }
    
    var cameraButtonTitle: String? {
        return "test camera button"
    }
    
    var photoLibraryButtonTitle: String? {
        return "test photo library button"
    }
    
    var maxNumOfKeys: Int {
        let numberOfTagsForIpad = self.maximumTagsForIpad() ?? 10
        let numberOfTagsForIphone = self.maximumTagsForIphone() ?? 7
        
        return (self.flowDelegate?.isDeviceIphone ?? true ? numberOfTagsForIphone : numberOfTagsForIpad)
    }
    
    func predictImage(ref: CVPixelBuffer, predictionImage: UIImage) {
        do {
            let predictions = try resnetModel.prediction(image: ref)
            let sorted = predictions.classLabelProbs.sorted(by: { (lhs, rhs) -> Bool in
                return lhs.value > rhs.value
            })
            
            self.emptyPredictionResultsArray()
            
            //The following code first does take the array from 0 to 7 or 10 (inclusive) and then removes all the "," from the element and then appends it to the array
            let _ = Array(0...maxNumOfKeys).map{ sorted[$0].key.split{$0 == ","}.map(String.init).map{self.predictedResults.append("\($0)")}}
            
            self.predictedResults = self.predictedResults.map{"#\($0.camelCaseStringLowerCase)"} // camelCasing and append #
            self.flowDelegate?.showPredictionResultsView(predictions: self.predictedResults, withPredictionImage: predictionImage)
            self.delegate?.removePredictionImage()
        } catch {
            print(error)
        }
    }
    
    func getAppStoreAppId() -> String {
        return "test app id"
    }
    
    func handleEmailAction() {
        self.flowDelegate?.showEmailView()
    }
    
    fileprivate func emptyPredictionResultsArray() {
        if self.predictedResults.count > 0 {
            self.predictedResults.removeAll()
        }
    }
    
    func feedbackButtonAction() {
        
    }
    
    func showFeedbackSubmissionIssue() {
        
    }
    
    func showImagePickerIssueAlert() {
    
    }
    
    func showPhotoPrivacyAccessIssueAlert() {
        
    }
}
