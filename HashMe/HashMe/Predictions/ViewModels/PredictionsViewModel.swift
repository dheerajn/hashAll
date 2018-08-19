//
//  PredictionsViewModel.swift
//  HashMe
//
//  Created by Dheeru on 9/23/17.
//  Copyright © 2017 Dheeru. All rights reserved.
//

import UIKit
import CoreML

enum PredictionAnimationDuration: Double {
    case mainLabelAnimationDuration = 1
}

class PredictionsViewModel: PredictionsViewConfigurable, AlertViewPresentable {
    
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
            let _ = Array(0...maxNumOfKeys).map{ sorted[$0].key.split{ $0 == "," }.map(String.init).map{ self.predictedResults.append("\($0)") }}
            
            self.predictedResults = self.predictedResults.map{"#\($0.camelCaseStringLowerCase)"} // camelCasing and append #
            self.flowDelegate?.showPredictionResultsView(predictions: self.predictedResults, withPredictionImage: predictionImage)
            self.delegate?.removePredictionImage()
        } catch {
            print(error)
        }
    }
    
    func getAppStoreAppId() -> String {
        return Constants.AppStoreAppID
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
        let appStoreAppUrl = URL(string: self.getAppStoreAppId())
        if let url = appStoreAppUrl {
            UIApplication.shared.open(url, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: { (urlOpened) in
                if urlOpened == false {
                    self.showFeedbackSubmissionIssue()
                }
            })
        }
    }
    
    func showFeedbackSubmissionIssue() {
        let dismissAction: CustomAlertAction = (title: LocalizedString.okButtonTitle, style: UIAlertAction.Style.default, handler: nil)
        self.displayAlertWithTitle(LocalizedString.appStoreOpenIssueTitle,
                                   message: LocalizedString.appStoreOpenIssueMessage,
                                   andActions: [dismissAction])
    }
    
    func showImagePickerIssueAlert() {
        let dismissAction: CustomAlertAction = (title: LocalizedString.okButtonTitle, style: UIAlertAction.Style.default, handler: nil)
        CustomAlertController().displayAlertWithTitle(LocalizedString.alertTitle,
                                                      message: LocalizedString.alertMessage,
                                                      preferredStyle: .alert,
                                                      andActions: [dismissAction])
    }
    
    func showPhotoPrivacyAccessIssueAlert() {
        let dismissAction: CustomAlertAction = (title: LocalizedString.noThanksButtonTitle, style: UIAlertAction.Style.destructive, handler: nil)
        let okAction: CustomAlertAction = (title: LocalizedString.settingsButtonTitle, style: UIAlertAction.Style.default, handler: {
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                })
            }
        })
        
        CustomAlertController().displayAlertWithTitle(LocalizedString.photoLibraryAccessTitle,
                                                      message: LocalizedString.photoLibraryAccessMessage,
                                                      preferredStyle: .alert,
                                                      andActions: [dismissAction, okAction])
    }
}
