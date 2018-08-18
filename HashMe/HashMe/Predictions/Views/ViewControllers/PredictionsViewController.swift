//
//  PredictionsViewController.swift
//  HashMe
//
//  Created by Dheeru on 9/23/17.
//  Copyright © 2017 Dheeru. All rights reserved.
//

import UIKit
import Photos
import CoreML

//https://github.com/ytakzk/CoreML-samples - help taken from this.
//TODO: try putting different models and compare the results of the prediction and combine everything.

//more image: https://www.flaticon.com/free-icon/more-circular-symbol_54555#term=more&page=1&position=67

class PredictionsViewController: BaseViewController, LoadingScreenPresentable {
    
    weak var flowDelegate: HashTagFlowDelegate?
    
    let imagePicker = UIImagePickerController()
    var viewModel: PredictionsViewConfigurable? {
        didSet {
            viewModel?.delegate = self
        }
    }
    var shouldHideContactsUsView: Bool = true {
        didSet {
            if shouldHideContactsUsView == true {
                hideContactUsView()
            } else {
                handleRightBarButtonAction()
            }
        }
    }
    
    @IBOutlet weak var descriptionLabel: CustomLabel!
    @IBOutlet weak var cameraButton: CustomButton!
    @IBOutlet weak var photoLibraryButton: CustomButton!
    @IBOutlet weak var imageToPredict: UIImageView!
    @IBOutlet weak var contactUsContainerView: CustomView!
    @IBOutlet weak var feedbackButton: UIButton!
    @IBOutlet weak var contactUsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUserInterface()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.setStatusBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = viewModel?.screenTitle ?? ""
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.removeLoadingAnimationFromSuperView()
    }
    
    @IBAction func cameraButtonTapped(_ sender: CustomButton) {
        shouldHideContactsUsView = true
        openCameraOrPhotoLibrary(sourceType: .camera)
    }
    
    @IBAction func photoLibraryTapped(_ sender: CustomButton) {
        shouldHideContactsUsView = true
        openCameraOrPhotoLibrary(sourceType: .photoLibrary)
    }
    
    @IBAction func predictButtonTapped() {
        let resized = imageToPredict.image?.resize(size: CGSize(width: 224, height: 224))
        guard let image = resized, let ref = image.buffer else {
            return
        }
        self.viewModel?.predictImage(ref: ref, predictionImage: imageToPredict.image ?? UIImage())
    }
    
    @objc func rightBarButtonTapped() {
        contactUsContainerView.isHidden == true ? (shouldHideContactsUsView = false) : (shouldHideContactsUsView = true)
    }
    
    @IBAction func feedbackButtonTapped(_ sender: Any) {
        let appStoreAppUrl = URL(string: self.viewModel?.getAppStoreAppId() ?? Constants.AppStoreAppID)
        if let url = appStoreAppUrl {
            UIApplication.shared.open(url, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: { (urlOpened) in
                if urlOpened == false {
                    self.showFeedbackSubmissionIssue()
                }
            })
        }
    }
    
    @IBAction func contactUsButtonTapped(_ sender: Any) {
        self.viewModel?.handleEmailAction()
    }
    
    deinit {
        print("\(self.description.debugDescription) deinit")
    }
}

//MARK: UI & Helper methods

extension PredictionsViewController {
    func openCameraOrPhotoLibrary(sourceType: UIImagePickerController.SourceType) {
        if sourceType == .camera {
            guard UIImagePickerController.isSourceTypeAvailable(sourceType) else {
                self.showImagePickerIssueAlert()
                return
            }
            self.imagePicker.sourceType = sourceType
            dispatchOnMainQueue {
                self.present(self.imagePicker, animated: true, completion: nil)
            }
        } else if sourceType == .photoLibrary {
            PHPhotoLibrary.requestAuthorization { (status) in
                switch status {
                case .authorized:
                    guard UIImagePickerController.isSourceTypeAvailable(sourceType) else {
                        self.showImagePickerIssueAlert()
                        return
                    }
                    self.imagePicker.sourceType = sourceType
                    dispatchOnMainQueue {
                        self.present(self.imagePicker, animated: true, completion: nil)
                    }
                case .restricted,.denied,.notDetermined:
                    self.showPhotoPrivacyAccessIssueAlert()
                    return
                }
            }
        }
    }
    
    func showImagePickerIssueAlert() {
        let dismissAction: CustomAlertAction = (title: LocalizedString.okButtonTitle, style: UIAlertAction.Style.default, handler: nil)
        CustomAlertController().displayAlertWithTitle(LocalizedString.alertTitle,
                                                      message: LocalizedString.alertMessage,
                                                      preferredStyle: .alert,
                                                      andActions: [dismissAction],
                                                      onViewController: self)
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
                                                      andActions: [dismissAction, okAction],
                                                      onViewController: self)
    }
    
    fileprivate func setupUserInterface() {
        if viewModel == nil {
            viewModel = PredictionsViewModel(flowDelegate: self.flowDelegate)
        }
        dispatchOnMainQueueWith(delay: 0.05) {
            self.hideLeftNavBarButton()
        }
        self.imagePicker.delegate = self
        addRightBarButton(withImage: UIImage.InfoImage, withAction: #selector(PredictionsViewController.rightBarButtonTapped))
        self.descriptionLabel.text = self.viewModel?.descriptionLabelText ?? ""
        self.descriptionLabel.animateAlpha(duration: PredictionAnimationDuration.mainLabelAnimationDuration.rawValue, delay: 0)
        
        self.cameraButton.setTitle(viewModel?.cameraButtonTitle, for: UIControl.State.normal)
        self.photoLibraryButton.setTitle(viewModel?.photoLibraryButtonTitle, for: .normal)
        
        hideContactsUsViewButtons()
        
        self.contactUsContainerView.setupMediumBluredViewOnImage(UIImage.AutumnImage)
        self.shouldHideContactsUsView = true
        
        self.view.setupMediumBluredViewOnImage(UIImage.SunshineGreenery)
    }
    
    func handleRightBarButtonAction() {
        UIView.animate(withDuration: 0.3, animations: {
            self.contactUsContainerView.isHidden = false
        }) { (animated) in
            UIView.animate(withDuration: 0.3, animations: {
                self.feedbackButton.transform = CGAffineTransform(translationX: 0, y: 0)
            }) { (animated) in
                UIView.animate(withDuration: 0.3, animations: {
                    self.contactUsButton.transform = CGAffineTransform(translationX: 0, y: 0)
                }, completion: nil)
            }
        }
    }
    
    func hideContactUsView() {
        UIView.animate(withDuration: 0.5) {
            self.contactUsContainerView.isHidden = true
            self.hideContactsUsViewButtons()
        }
    }
    
    fileprivate func hideContactsUsViewButtons() {
        self.feedbackButton.transform = CGAffineTransform(scaleX: 0, y: -0.05)
        self.contactUsButton.transform = CGAffineTransform(scaleX: 0, y: -0.05)
    }
    
    fileprivate func showFeedbackSubmissionIssue() {
        let dismissAction: CustomAlertAction = (title: LocalizedString.okButtonTitle, style: UIAlertAction.Style.default, handler: nil)
        CustomAlertController().displayAlertWithTitle(LocalizedString.appStoreOpenIssueTitle,
                                                      message: LocalizedString.appStoreOpenIssueMessage,
                                                      preferredStyle: .alert,
                                                      andActions: [dismissAction],
                                                      onViewController: self)
    }
}

//MARK: UIImagePickerControllerDelegate

extension PredictionsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        self.imageToPredict.image = image
        imagePicker.dismiss(animated: true) {
            //reason behind putting a delay is because user has to know that there is something loading. If no delay, loading screen is not showing up on the screen
            dispatchOnMainQueueWith(delay: 1, closure: {
                self.predictButtonTapped()
            })
            UIView.animate(withDuration: 0.2, animations: {
                self.startLoadingAnimation()
            })
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePicker.dismiss(animated: true, completion: nil)
    }
}

//MARK: PredictionsViewDelegate

extension PredictionsViewController: PredictionsViewDelegate {
    func removePredictionImage() {
        self.imageToPredict.image = nil
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
	return input.rawValue
}
