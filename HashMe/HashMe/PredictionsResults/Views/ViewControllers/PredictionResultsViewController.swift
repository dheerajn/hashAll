//
//  PredictionResultsViewController.swift
//  HashMe
//
//  Created by Dheeru on 9/23/17.
//  Copyright © 2017 Dheeru. All rights reserved.
//

import UIKit
import AVFoundation

class PredictionResultsViewController: BaseViewController {
    
    @IBOutlet weak var copiedLabel: CustomLabel!
    @IBOutlet weak var socialMediaView: SocialMediaCustomView!
    @IBOutlet weak var copiedView: CustomView!
    @IBOutlet weak var selectAllButton: CustomButton!
    @IBOutlet weak var copyButton: CustomButton!
    @IBOutlet weak var predictionResultsCollectionView: UICollectionView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var shareButton: CustomButton!
    
    var viewModel: PredictionResultsViewConfigurable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.resetStatusBar()
        addLeftBarButton(withAction: #selector(PredictionResultsViewController.leftBarButtonTapped))
        addRightBarButton(withImage: UIImage.addImage, withAction: #selector(PredictionResultsViewController.addNewTagButtonTapped), withAnimation: true)
    }
    
    @objc func leftBarButtonTapped() {
        self.viewModel?.flowDelegate?.popViewControllerWithAnimation(withAnimationType: .fade)
    }
    
    @objc func addNewTagButtonTapped() {
        self.addNewHashTagManually()
    }
    
    @IBAction func copyButtonTapped(_ sender: Any) {
        self.viewModel?.copyHashTagsToPasteboard()
        self.animateCopiedView()
    }
    
    @IBAction func shareButtonTapped(_ sender: Any) {
        self.resetSocialMediaView()
    }
    
    @IBAction func selectAllButtonTapped(_ sender: Any) {
        let buttonTitle = selectAllButton.titleLabel?.text
        
        if buttonTitle == LocalizedString.selecAllButtonTitle {
            self.selectAllButton.setTitle(LocalizedString.deselecAllButtonTitle, for: .normal)
            
            self.viewModel?.selectAllButtonTapped()
            guard let validPredictionResultsCollectionViewCells = predictionResultsCollectionView.visibleCells as? [PredictionResultCollectionViewCell] else { return }
            
            let _ = validPredictionResultsCollectionViewCells.map{$0.isPredictionSelected = true; $0.scaleToIdentityWith3DAnimation()}
            
            self.shouldEnableCopyButton()
        } else if buttonTitle == LocalizedString.deselecAllButtonTitle {
            self.selectAllButton.setTitle(LocalizedString.selecAllButtonTitle, for: .normal)
            
            self.viewModel?.deselectAllButtonTapped()
            guard let validPredictionResultsCollectionViewCells = predictionResultsCollectionView.visibleCells as? [PredictionResultCollectionViewCell] else { return }
            
            let _ = validPredictionResultsCollectionViewCells.map{$0.isPredictionSelected = false; $0.scaleDownForAnimation()}
            
            self.shouldEnableCopyButton()
        }
    }
    
    func addNewHashTagManually() {
        let alertController = UIAlertController(title: "Add a new Tag", message: "", preferredStyle: .alert)
        
        let doneAction = UIAlertAction(title: "Done", style: .default, handler: self.insertNewHashTag(alertController: alertController))
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        alertController.addTextField { (hashtagTextField) in
            hashtagTextField.placeholder = "Add your new #hashtag"
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(doneAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func insertNewHashTag(alertController: UIAlertController) -> ((UIAlertAction) -> Void) {
        let hashtag: ((UIAlertAction) -> Void) = { (alert) in
            let textField = alertController.textFields![0] as UITextField
            guard let validHashTag = textField.text else { return }
            
            self.viewModel?.originalPredictions?.append(validHashTag)
            self.viewModel?.updatedPredicitons?.append(validHashTag)
            
            //here we did "(self.viewModel?.originalPredictions?.count ?? 0) - 1" because, first we want to add the new element in the "originalPredictions.count" value but we did add an element to the array so count will be incremented by 1 and there might be a crash since we are out of the index, so we inserting by decrementing 1 value.
            let indexPathForNewElement = IndexPath(item: (self.viewModel?.originalPredictions?.count ?? 0) - 1, section: 0)
            self.predictionResultsCollectionView.insertItems(at: [indexPathForNewElement])
            self.collectionView(self.predictionResultsCollectionView, didSelectItemAt: indexPathForNewElement, shouldUpdateVmPredictionsArray: false)
        }
        return hashtag
    }
}

//MARK: UI and helper methods

extension PredictionResultsViewController {
    fileprivate func configureUI() {
        self.view.setupLightBluredViewOnImage(UIImage.NatureImage)
        
        self.predictionResultsCollectionView.delegate = self
        self.predictionResultsCollectionView.dataSource = self
        self.predictionResultsCollectionView.backgroundColor = UIColor.clear
        
        self.copyButton.setTitle(viewModel?.copyButtonTitle, for: UIControlState.normal)
        self.shouldEnableCopyButton()
        
        self.selectAllButton.setTitle(viewModel?.selectAllButtonTitle, for: UIControlState.normal)
        
        self.copiedLabel.text = viewModel?.copiedLabelTitle
        self.moveCopiedViewOutsideBounds()
        self.moveSocialMediaCustomViewOutsideBounds()
        
        handleShareSheetActions()
        StoreReviewHelper.checkAndAskForReview()
    }
    
    fileprivate func handleShareSheetActions() {
        self.socialMediaView.instagramButtonCustomHander = {
            let url = URL(string: "instagram://camera")
            if let url = url {
                UIApplication.shared.open(url, options: [:], completionHandler: { (urlOpened) in
                    if urlOpened == false {
                        self.showInstagramAlertIssue()
                    }
                })
            }
        }
        
        self.socialMediaView.dismissButtonCustomHandler = {
            self.moveSocialMediaCustomViewOutsideBounds(withAnimation: true)
        }
        
        self.socialMediaView.moreButtonCustomHandler = {
            if (self.viewModel?.updatedPredicitons?.count ?? 0) >= 1 {
                self.handleMoreButtonAction()
            } else {
                let dismissAction: CustomAlertAction = (title: LocalizedString.okButtonTitle, style: UIAlertActionStyle.default, handler: nil)
                let noThanks: CustomAlertAction = (title: LocalizedString.noThanksButtonTitle, style: UIAlertActionStyle.default, handler: {
                    self.handleMoreButtonAction()
                })
                CustomAlertController().displayAlertWithTitle(nil,
                                                              message: LocalizedString.askForCopyingTags,
                                                              preferredStyle: .alert,
                                                              andActions: [dismissAction, noThanks],
                                                              onViewController: self)
            }
        }
    }
    
    fileprivate func handleMoreButtonAction() {
        self.moveSocialMediaCustomViewOutsideBounds(withAnimation: true)
        
        let shareButtonFrame = self.shareButton.frame
        let sourceFrame = CGRect(x: (shareButtonFrame.origin.x + shareButtonFrame.width/2), y: self.stackView.frame.origin.y, width: shareButtonFrame.width, height: shareButtonFrame.height)
        self.viewModel?.launchShareActivity(withFrame: sourceFrame)
    }
    
    fileprivate func animateCopiedView() {
        self.copiedView.center = self.view.center
        UIView.animate(withDuration: PredictionResultsAnimationDuration.copiedAnimation.rawValue, animations: {
            self.copiedView.alpha = 1
        }) { (success) in
            UIView.animate(withDuration: PredictionResultsAnimationDuration.copiedAnimation.rawValue, animations: {
                self.copiedView.alpha = 0
            }, completion: { (success) in
                self.moveCopiedViewOutsideBounds()
            })
        }
    }
    
    fileprivate func moveCopiedViewOutsideBounds() {
        self.copiedView.frame.origin.y = UIScreen.main.bounds.maxY
        self.copiedView.alpha = 0
    }
    
    fileprivate func moveSocialMediaCustomViewOutsideBounds(withAnimation: Bool = false) {
        
        func moveSocialMediaOutside() {
            self.socialMediaView.transform = CGAffineTransform(translationX: 0, y: 200)
        }
        
        if withAnimation {
            UIView.animate(withDuration: PredictionResultsAnimationDuration.hidingAnimationDuration.rawValue) {
                moveSocialMediaOutside()
            }
        } else {
            moveSocialMediaOutside()
        }
    }
    
    fileprivate func resetSocialMediaView() {
        UIView.animate(withDuration: PredictionResultsAnimationDuration.hidingAnimationDuration.rawValue) {
            self.socialMediaView.transform = CGAffineTransform.identity
        }
    }
    
    fileprivate func shouldEnableCopyButton() {
        let selectedPredictionsCount = viewModel?.updatedPredicitons?.count ?? 0
        selectedPredictionsCount >= 1 ? enableCopyButton() : disableCopyButton()
    }
    
    fileprivate func updateButtonTitle() {
        let selectedPredictionsCount = viewModel?.updatedPredicitons?.count ?? 0
        
        if selectedPredictionsCount == 0 {
            if self.selectAllButton.titleLabel?.text == LocalizedString.deselecAllButtonTitle {
                self.selectAllButton.setTitle(LocalizedString.selecAllButtonTitle, for: .normal)
            }
        } else if selectedPredictionsCount == self.viewModel?.originalPredictions?.count {
            if self.selectAllButton.titleLabel?.text == LocalizedString.selecAllButtonTitle {
                self.selectAllButton.setTitle(LocalizedString.deselecAllButtonTitle, for: .normal)
            }
        }
    }
    
    fileprivate func enableCopyButton() {
        self.copyButton.isEnabled = true
        self.copyButton.layer.borderColor = UIColor.white.cgColor
        self.copyButton.setTitleColor(UIColor.white, for: .normal)
    }
    
    fileprivate func disableCopyButton() {
        self.copyButton.isEnabled = false
        self.copyButton.layer.borderColor = UIColor.darkGray.cgColor
        self.copyButton.setTitleColor(UIColor.darkGray, for: .normal)
    }
    
    fileprivate func showInstagramAlertIssue() {
        let dismissAction: CustomAlertAction = (title: LocalizedString.noThanksButtonTitle, style: UIAlertActionStyle.cancel, handler: nil)
        let installNow: CustomAlertAction = (title: LocalizedString.okButtonTitle, style: UIAlertActionStyle.default, handler: {
            let url = URL(string: Constants.InstagramAppId)
            guard let instagramUrl = url else { return }
            UIApplication.shared.open(instagramUrl, options: [:], completionHandler: { (urlOpened) in
                urlOpened == false ? print("issue directing user to instagram app") : ()
            })
        })
        
        CustomAlertController().displayAlertWithTitle(LocalizedString.instagramIssueTitle,
                                                      message: LocalizedString.installNowMessage,
                                                      preferredStyle: .alert,
                                                      andActions: [dismissAction, installNow],
                                                      onViewController: self)
    }
}

// MARK: UICollectionViewDelegateFlowLayout

extension PredictionResultsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let predictions = viewModel?.originalPredictions
        guard let validPredictions = predictions else { return CGSize() }
        let text = validPredictions[indexPath.row]
        let font = UIFont.systemFont(ofSize: 18)
        let rect = NSString(string: text).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        
        return CGSize(width: rect.width + 20, height: rect.height + 10)
    }
}


// MARK: UICollectionViewDataSource

extension PredictionResultsViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.collectionView(collectionView, numberOfItemsInSection: section) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let predictionCell = collectionView.dequeueReusableCell(withReuseIdentifier: PredictionResultCollectionViewCell.reuseID(), for: indexPath) as? PredictionResultCollectionViewCell else { return UICollectionViewCell() }

        guard let validPredictions = viewModel?.originalPredictions else { return UICollectionViewCell() }
        predictionCell.predictionDisplayLabel.text = validPredictions[indexPath.row]
        
        predictionCell.isPredictionSelected = false
        if predictionCell.isPredictionSelected == false {
            predictionCell.scaleDownForAnimation()
        }
        animateCell(predictionCell)
        return predictionCell
    }
    
    fileprivate func animateCell(_ predictionCell: PredictionResultCollectionViewCell) {
        predictionCell.alpha = 0
        predictionCell.layer.transform = CATransform3DMakeScale(0.7, 0.7, 0.7)
        
        dispatchOnMainQueueWith(delay: 0.5) {
            UIView.animate(withDuration: PredictionResultsAnimationDuration.cellAnimation.rawValue, animations: {
                predictionCell.alpha = 1
                predictionCell.layer.transform = CATransform3DScale(CATransform3DIdentity, 0.9, 0.9, 0.9)
            })
        }
    }
}

// MARK: UICollectionViewDelegate
extension PredictionResultsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        self.collectionView(collectionView, didSelectItemAt: indexPath, shouldUpdateVmPredictionsArray: true)
    }
    
    
    /// This is a helper method for didSelectItemAt
    ///
    /// - Parameters:
    ///   - collectionView: collectionView to be considered
    ///   - indexPath: indexPath to be considered
    ///   - shouldUpdateVmPredictionsArray: if this property is set to true, then if will the selecte tag to viewModel's updatedPridictionArray else if will not update. This is used when manual tag buton is tapped.
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath, shouldUpdateVmPredictionsArray: Bool = true) {
        guard let selectedPredictionCell = predictionResultsCollectionView.cellForItem(at: indexPath) as? PredictionResultCollectionViewCell else { return }
        if selectedPredictionCell.isPredictionSelected == true {
            selectedPredictionCell.isPredictionSelected = false
            selectedPredictionCell.scaleDownForAnimation()
        } else {
            selectedPredictionCell.isPredictionSelected = true
            selectedPredictionCell.scaleToIdentityWith3DAnimation()
        }
        
        if shouldUpdateVmPredictionsArray {
            self.viewModel?.updatePredictionsArray(forHashTag: selectedPredictionCell.predictionDisplayLabel.text ?? "")
        }
        self.shouldEnableCopyButton()
        self.updateButtonTitle()
    }
}
