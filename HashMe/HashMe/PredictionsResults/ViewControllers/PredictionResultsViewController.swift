//
//  PredictionResultsViewController.swift
//  HashMe
//
//  Created by Dheeru on 9/23/17.
//  Copyright © 2017 Dheeru. All rights reserved.
//

import UIKit

class PredictionResultsViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var predictionResultsCollectionView: UICollectionView!
    
    let columns: CGFloat = 3.0
    let inset: CGFloat = 8.0
    let spacing: CGFloat = 8.0
    let lineSpacing: CGFloat = 8.0
    
    var viewModel: PredictionResultsViewConfigurable? {
        didSet {
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.predictionResultsCollectionView.delegate = self
        self.predictionResultsCollectionView.dataSource = self
        self.predictionResultsCollectionView.backgroundColor = UIColor.clear
        
        
    }
    
    // MARK: UICollectionViewDataSource
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
    
    // MARK: UICollectionViewDataDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    // MARK: UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = Int((collectionView.frame.width / columns) - (inset + spacing))
        
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return lineSpacing
    }
}
