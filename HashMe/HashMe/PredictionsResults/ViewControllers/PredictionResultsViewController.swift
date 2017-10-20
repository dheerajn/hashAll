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
    
    @IBOutlet weak var socialMediaView: SocialMediaCustomView!
    @IBOutlet weak var copiedView: CustomView!
    @IBOutlet weak var copyButton: CustomButton!
    @IBOutlet weak var predictionResultsCollectionView: UICollectionView!
    
    var hidingAnimationDuration = 0.5
    
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
        self.viewModel?.copyImagesToPasteboard()
        self.animateCopiedView()
    }
    
}

//MARK: UI
extension PredictionResultsViewController {
    func configureUI() {
        self.view.setupLightBluredViewOnImage(UIImage.NatureImage)
        
        self.predictionResultsCollectionView.delegate = self
        self.predictionResultsCollectionView.dataSource = self
        self.predictionResultsCollectionView.backgroundColor = UIColor.clear
        
        let layout = predictionResultsCollectionView.collectionViewLayout as! PredictionViewLayout
        layout.delegate = self
        layout.numberOfColumns = 3
        layout.cellPadding = 5
        
        self.copyButton.setTitle(viewModel?.copyButtonTitle, for: UIControlState.normal)
        self.moveCopiedViewOutsideBounds()
        self.moveSocialMediaCustomViewOutsideBounds()
        
        handleShareSheetActions()
    }
    
    func handleShareSheetActions() {
        self.socialMediaView.instagramButtonCustomHander = {
            let url = URL(string: "instagram://camera")
            UIApplication.shared.open(url!, options: [:], completionHandler: nil)
        }
        
        self.socialMediaView.dismissButtonCustomHandler = {
            self.moveSocialMediaCustomViewOutsideBounds(withAnimation: true)
        }
        
        self.socialMediaView.moreButtonCustomHandler = {
            self.moveSocialMediaCustomViewOutsideBounds(withAnimation: true)
            //The following codes helps in dismissing the custom share sheet and then presenting UIActivityVc
            DispatchQueue.main.asyncAfter(deadline: TimeInterval.convertToDispatchTimeT(self.hidingAnimationDuration), execute: {
                self.viewModel?.launchShareActivity()
            })
        }
    }
    
    fileprivate func animateCopiedView() {
        self.copiedView.center = self.view.center
        UIView.animate(withDuration: 0.75, animations: {
            self.copiedView.alpha = 1
        }) { (success) in
            UIView.animate(withDuration: 1, animations: {
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
            UIView.animate(withDuration: hidingAnimationDuration) {
                moveSocialMediaOutside()
            }
        } else {
            moveSocialMediaOutside()
        }
    }
    
    fileprivate func resetSocialMediaView() {
        UIView.animate(withDuration: hidingAnimationDuration) {
            self.socialMediaView.transform = CGAffineTransform.identity
        }
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
        predictionCell.isPredictionSelected = true
        
        return predictionCell
    }
}

// MARK: UICollectionViewDelegate
extension PredictionResultsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        guard let selectedPredictionCell = predictionResultsCollectionView.cellForItem(at: indexPath) as? PredictionResultCollectionViewCell else { return }
        if selectedPredictionCell.isPredictionSelected == true {
            selectedPredictionCell.isPredictionSelected = false
        } else {
            selectedPredictionCell.isPredictionSelected = true
        }
        self.viewModel?.updatePredictionsArray(forHashTag: selectedPredictionCell.predictionDisplayLabel.text ?? "")
    }
}

// MARK: PredictionLayoutDelegate
extension PredictionResultsViewController: PredictionLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, heightForImageAtIndexPath indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat {
        return 0.0
    }
    
//    func collectionView(_ collectionView: UICollectionView, heightForDescriptionAtIndexPath indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat {
//        guard let validPrediction = viewModel?.originalPredictions else { return 0.001 }
//        if indexPath.row > validPrediction.count {
//            return 0.001
//        }
//        
//        let character = validPrediction[indexPath.row]
//        let descriptionHeight = heightForText(character.description, width: (width - 24))
//        let height = 4 + 17 + 4 + descriptionHeight + 12
//        return height
//    }
//    
//    func heightForText(_ text: String, width: CGFloat) -> CGFloat {
//        let font = UIFont.systemFont(ofSize: 18)
//        let rect = NSString(string: text).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
//        return ceil(rect.height)
//    }

    func collectionView(_ collectionView: UICollectionView, widthForDescriptionAtIndexPath indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat {
        guard let validPrediction = viewModel?.originalPredictions else { return 0.001 }
        if indexPath.row > validPrediction.count {
            return 0.001
        }
        
        let character = validPrediction[indexPath.row]
        let descriptionHeight = widthForText(character.description, width: (width - 24))
        let height = 4 + 17 + 4 + descriptionHeight + 12
        return height
    }
    
    func widthForText(_ text: String, width: CGFloat) -> CGFloat {
        let font = UIFont.systemFont(ofSize: 18)
        let rect = NSString(string: text).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: width), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        return ceil(rect.width)
    }
}
