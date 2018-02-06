//
//  ViewController.swift
//  Swash
//
//  Created by Sam Francis on 01/26/2018.
//  Copyright (c) 2018 Mindgrub. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak private var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        label.font = Papyrus.condensed.of(textStyle: .largeTitle, defaultSize: 34, maxSize: 50)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if previousTraitCollection?.preferredContentSizeCategory != traitCollection.preferredContentSizeCategory {
            label.font = Papyrus.condensed.of(textStyle: .largeTitle, defaultSize: 34, maxSize: 50)
        }
    }
    
}
