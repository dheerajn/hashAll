//
//  HashTagsViewController.swift
//  HashMe
//
//  Created by Dheeru on 9/23/17.
//  Copyright © 2017 Dheeru. All rights reserved.
//

import UIKit

class HashTagsViewController: UIViewController {

    var viewModel: HashTagsViewConfigurable? {
        didSet {
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = viewModel?.screenTitle
    }
}
