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
    
    @IBOutlet weak var copiedView: CustomView!
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
        addRightBarButton(withImage: UIImage.ShareImage, withAction: #selector(PredictionResultsViewController.shareButtonTapped))
    }
    
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
        
        self.moveViewOutside()
    }
    
    @objc func leftBarButtonTapped() {
        self.viewModel?.flowDelegate?.popViewControllerWithAnimation(withAnimationType: .fade)
    }
    
    @objc func shareButtonTapped() {
        self.viewModel?.launchShareActivity()
    }
    
    @IBAction func copyButtonTapped(_ sender: Any) {
        UIPasteboard.general.strings = self.viewModel?.predictions
        self.animateCopiedView()
    }
    
    fileprivate func animateCopiedView() {
        UIView.animate(withDuration: 0.75, animations: {
            self.copiedView.center = self.view.center
        }) { (success) in
            UIView.animate(withDuration: 1, animations: {
                self.copiedView.alpha = 0
            }, completion: { (success) in
                self.copiedView.alpha = 1
                self.moveViewOutside()
            })
        }
    }
    
    fileprivate func moveViewOutside() {
        self.copiedView.frame.origin.y = UIScreen.main.bounds.maxY
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
        guard let predictionCell = collectionView.dequeueReusableCell(withReuseIdentifier: PredictionResultCollectionViewCell.reuseID(), for: indexPath) as? PredictionResultCollectionViewCell else {
            return UICollectionViewCell()
            
        }
        predictionCell.predictionDisplayLabel.text = viewModel?.predictions![indexPath.row]
        return predictionCell
    }
    
}

// MARK: UICollectionViewDelegate
extension PredictionResultsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
// MARK: PredictionLayoutDelegate
extension PredictionResultsViewController: PredictionLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, heightForImageAtIndexPath indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, heightForDescriptionAtIndexPath indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat {
        guard let validPrediction = viewModel?.predictions else { return 0.001 }
        if indexPath.row > validPrediction.count {
            return 0.001
        }
        
        let character = validPrediction[indexPath.row]
        let descriptionHeight = heightForText(character.description, width: (width - 24))
        let height = 4 + 17 + 4 + descriptionHeight + 12
        return height
    }
    
    func heightForText(_ text: String, width: CGFloat) -> CGFloat {
        let font = UIFont.systemFont(ofSize: 10)
        let rect = NSString(string: text).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        return ceil(rect.height)
    }
}
