//
//  ViewController.swift
//  Swash
//
//  Created by Sam Francis on 01/26/2018.
//  Copyright (c) 2018 Mindgrub. All rights reserved.
//

import UIKit
import Swash

class ViewController: UIViewController {
    
    @IBOutlet weak private var label1: UILabel!
    @IBOutlet weak private var label2: UILabel!
    @IBOutlet weak private var label3: UILabel!
    @IBOutlet weak private var label4: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        label1.font = Papyrus.condensed.of(textStyle: .headline, defaultSize: 17)
        label2.font = GillSans.bold.of(textStyle: .title1, defaultSize: 28, maxSize: 38)
        label3.font = SystemFont.preferred.of(textStyle: .caption1)
        label4.font = SystemFont.heavy.of(textStyle: .body)
        
        label1.text = "\(label1.font.fontDescriptor.postscriptName)"
        label2.text = "\(label2.font.fontDescriptor.postscriptName)"
        label3.text = "\(label3.font.fontDescriptor.postscriptName)"
        label4.text = "\(label4.font.fontDescriptor.postscriptName)"
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.preferredContentSizeCategory != previousTraitCollection?.preferredContentSizeCategory {
            label4.font = SystemFont.heavy.of(textStyle: .body)
        }
    }
    
}
