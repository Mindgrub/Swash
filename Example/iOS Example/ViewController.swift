//
//  ViewController.swift
//  Swash
//
//  Created by Sam Francis on 01/26/2018.
//  Copyright © 2018 Mindgrub. All rights reserved.
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
        
        label1.font = Futura.condensedMedium.of(textStyle: .headline, maxSize: 24)
        label2.font = Avenir.light.of(style: .title1)
        label3.font = SystemFont.preferred.of(textStyle: .caption1)
        label4.font = SystemFont.heavy.of(textStyle: .body)
        
        label1.text = label1.font.fontName
        label2.text = label2.font.fontName
        label3.text = label3.font.fontName
        label4.text = label4.font.fontName
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.preferredContentSizeCategory != previousTraitCollection?.preferredContentSizeCategory {
            label2.font = Avenir.light.of(style: .title1)
            label4.font = SystemFont.heavy.of(textStyle: .body)
        }
    }
    
}
