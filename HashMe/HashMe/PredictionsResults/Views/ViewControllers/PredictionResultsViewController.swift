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
    
    var viewModel: PredictionResultsViewConfigurable? {
        didSet {
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.resetStatusBar()
        addLeftBarButton(withAction: #selector(PredictionResultsViewController.leftBarButtonTapped))
        addRightBarButton(withImage: UIImage.ShareImage, withAction: #selector(PredictionResultsViewController.rightBarButtonTapped), withAnimation: true)
    }

    @objc func leftBarButtonTapped() {
        self.viewModel?.flowDelegate?.popViewControllerWithAnimation(withAnimationType: .fade)
    }
    
    @objc func rightBarButtonTapped() {
        self.resetSocialMediaView()
    }
    
    @IBAction func copyButtonTapped(_ sender: Any) {
        self.viewModel?.copyHashTagsToPasteboard()
        self.animateCopiedView()
    }
    
    @IBAction func selectAllButtonTapped(_ sender: Any) {
        self.viewModel?.selectAllButtonTapped()
        guard let validPredictionResultsCollectionViewCells = predictionResultsCollectionView.visibleCells as? [PredictionResultCollectionViewCell] else { return }
        
        let _ = validPredictionResultsCollectionViewCells.map{$0.isPredictionSelected = true; $0.scaleToIdentityWith3DAnimation()}
        
        self.shouldEnableCopyButton()
    }
}

//MARK: UI
extension PredictionResultsViewController {
    fileprivate func configureUI() {
        self.view.setupLightBluredViewOnImage(UIImage.NatureImage)
        
        self.predictionResultsCollectionView.delegate = self
        self.predictionResultsCollectionView.dataSource = self
        self.predictionResultsCollectionView.backgroundColor = UIColor.clear
        
        let layout = predictionResultsCollectionView.collectionViewLayout as! PredictionViewLayout
        layout.delegate = self
        layout.numberOfColumns = 3
        layout.cellPadding = 5
        
        self.copyButton.setTitle(viewModel?.copyButtonTitle, for: UIControlState.normal)
        self.shouldEnableCopyButton()
        
        self.selectAllButton.setTitle(viewModel?.selectAllButtonTitle, for: UIControlState.normal)
        
        self.copiedLabel.text = viewModel?.copiedLabelTitle
        self.moveCopiedViewOutsideBounds()
        self.moveSocialMediaCustomViewOutsideBounds()
        
        handleShareSheetActions()
    }
    
    fileprivate func handleShareSheetActions() {
        self.socialMediaView.instagramButtonCustomHander = {
            let url = URL(string: "instagram://camera")
            if let url = url {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        
        self.socialMediaView.dismissButtonCustomHandler = {
            self.moveSocialMediaCustomViewOutsideBounds(withAnimation: true)
        }
        
        self.socialMediaView.moreButtonCustomHandler = {
            self.moveSocialMediaCustomViewOutsideBounds(withAnimation: true)
            //The following codes helps in dismissing the custom share sheet and then presenting UIActivityVc
            dispatchOnMainQueueWith(delay: PredictionResultsAnimationDuration.hidingAnimationDuration.rawValue, closure: {
                self.viewModel?.launchShareActivity()
            })
        }
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
        guard let selectedPredictionCell = predictionResultsCollectionView.cellForItem(at: indexPath) as? PredictionResultCollectionViewCell else { return }
        if selectedPredictionCell.isPredictionSelected == true {
            selectedPredictionCell.isPredictionSelected = false
            selectedPredictionCell.scaleDownForAnimation()
        } else {
            selectedPredictionCell.isPredictionSelected = true
            selectedPredictionCell.scaleToIdentityWith3DAnimation()
        }
        self.viewModel?.updatePredictionsArray(forHashTag: selectedPredictionCell.predictionDisplayLabel.text ?? "")
        self.shouldEnableCopyButton()
    }
}

// MARK: PredictionLayoutDelegate
extension PredictionResultsViewController: PredictionLayoutDelegate {

    func collectionView(_ collectionView: UICollectionView, widthForDescriptionAtIndexPath indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat {
        guard let validPrediction = viewModel?.originalPredictions else { return 0.001 }
        if indexPath.row > validPrediction.count {
            return 0.001
        }
        
        let character = validPrediction[indexPath.row]
        let descriptionHeight = widthForText(character.description, width: (width - 24))
        let width = descriptionHeight + 17
        return width
    }
    
    func widthForText(_ text: String, width: CGFloat) -> CGFloat {
        let font = UIFont.systemFont(ofSize: 18)
        let rect = NSString(string: text).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: width), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        return ceil(rect.width)
    }
}
