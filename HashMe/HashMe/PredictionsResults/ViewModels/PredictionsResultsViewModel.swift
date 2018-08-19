//
//  PredictionsResultsViewModel.swift
//  HashMe
//
//  Created by Dheeru on 9/23/17.
//  Copyright © 2017 Dheeru. All rights reserved.
//

import Foundation
import UIKit

enum PredictionResultsAnimationDuration: Double {
    case copiedAnimation = 1
    case hidingAnimationDuration = 0.5
    case cellAnimation = 0.4
}

class PredictionsResultsViewModel: PredictionResultsViewConfigurable, AlertViewPresentable {
    
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
        return LocalizedString.copyButtonTitle
    }
    
    var selectAllButtonTitle: String? {
        return LocalizedString.selecAllButtonTitle
    }
    
    var copiedLabelTitle: String? {
        return LocalizedString.copiedText
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.originalPredictions?.count ?? 0
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
        let _ = self.updatedPredicitons?.map{activitiesToBeShared.add($0)}
        let appName = Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String ?? "\(LocalizedString.appNameCamelCased)App"
        
        let formattedAppName = self.appendHashToString(tobeFormattedString: appName)
        activitiesToBeShared.add(formattedAppName ?? "")
        return activitiesToBeShared
    }
    
    func askToCopyTagsAlert() {
        let dismissAction: CustomAlertAction = (title: LocalizedString.okButtonTitle, style: UIAlertAction.Style.default, handler: nil)
        let noThanks: CustomAlertAction = (title: LocalizedString.noThanksButtonTitle, style: UIAlertAction.Style.default, handler: {
            self.delegate?.handleMoreButtonAction()
        })
        self.displayAlertWithTitle(nil,
                                   message: LocalizedString.askForCopyingTags,
                                   andActions: [dismissAction, noThanks])
    }
    
    func showInstagramAlertIssue() {
        let dismissAction: CustomAlertAction = (title: LocalizedString.noThanksButtonTitle, style: UIAlertAction.Style.cancel, handler: nil)
        let installNow: CustomAlertAction = (title: LocalizedString.okButtonTitle, style: UIAlertAction.Style.default, handler: {
            let url = URL(string: Constants.InstagramAppId)
            guard let instagramUrl = url else { return }
            UIApplication.shared.open(instagramUrl, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: { (urlOpened) in
                urlOpened == false ? print("issue directing user to instagram app") : ()
            })
        })
        self.displayAlertWithTitle(LocalizedString.instagramIssueTitle,
                                   message: LocalizedString.installNowMessage,
                                   andActions: [dismissAction, installNow])
    }
}

