//
//  HashTagsViewController.swift
//  HashMe
//
//  Created by Dheeru on 9/23/17.
//  Copyright © 2017 Dheeru. All rights reserved.
//

import UIKit
import CoreML

class HashTagsViewController: UIViewController {
    
    // Deep Residual Learning for Image Recognition
    // https://arxiv.org/abs/1512.03385
    let resnetModel = Resnet50()
    let imagePicker = UIImagePickerController()
    
    var viewModel: HashTagsViewConfigurable? {
        didSet {
            
        }
    }
    @IBOutlet weak var cameraButton: CustomButton!
    @IBOutlet weak var photoLibraryButton: CustomButton!
    @IBOutlet weak var predictButton: CustomButton!
    @IBOutlet weak var imageToPredict: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if viewModel == nil {
            viewModel = HashTagsViewModel()
        }
        setupUserInterface()
    }
    
    func setupUserInterface() {
        self.title = viewModel?.screenTitle
        self.cameraButton.setTitle(viewModel?.cameraButtonTitle, for: UIControlState.normal)
        self.photoLibraryButton.setTitle(viewModel?.photoLibraryButtonTitle, for: .normal)
        self.predictButton.setTitle(viewModel?.predictButtonTitle, for: .normal)
    }
    
    @IBAction func cameraButtonTapped(_ sender: CustomButton) {
        
    }
    
    @IBAction func photoLibraryTapped(_ sender: CustomButton) {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            return
        }
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func predictButtonTapped(_ sender: CustomButton) {
        guard let image = imageToPredict.image, let ref = image.buffer else {
            return
        }
        resnet(ref: ref)
    }
}

extension HashTagsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage,
            let resized = image.resize(size: CGSize(width: 224, height: 224)) else {
                return
        }
        self.imageToPredict.image = resized
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePicker.dismiss(animated: true, completion: nil)
    }
}

private extension HashTagsViewController {
    
    func resnet(ref: CVPixelBuffer) {
        do {
            let predictions = try resnetModel.prediction(image: ref)
            let sorted = predictions.classLabelProbs.sorted(by: { (lhs, rhs) -> Bool in
                return lhs.value > rhs.value
            })
            print("the results are \(sorted[0].key): \(NSString(format: "%.2f", sorted[0].value))\n \(sorted[1].key): \(NSString(format: "%.2f", sorted[1].value))\n \(sorted[2].key): \(NSString(format: "%.2f", sorted[2].value))\n \(sorted[3].key): \(NSString(format: "%.2f", sorted[3].value))\n \(sorted[4].key): \(NSString(format: "%.2f", sorted[4].value))\n \(sorted[5].key): \(NSString(format: "%.2f", sorted[5].value))\n \(sorted[6].key): \(NSString(format: "%.2f", sorted[6].value))")
        } catch {
            print(error)
        }
    }
}
