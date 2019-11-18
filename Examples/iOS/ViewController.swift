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
    
    @IBOutlet private weak var label1: UILabel!
    @IBOutlet private weak var label2: UILabel!
    @IBOutlet private weak var label3: UILabel!
    @IBOutlet private weak var label4: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // These are set in interface builder, so no need to set them here.
//        label1.adjustsFontForContentSizeCategory = true
//        label2.adjustsFontForContentSizeCategory = true
//        label3.adjustsFontForContentSizeCategory = true
//        label4.adjustsFontForContentSizeCategory = true
        
        updateFonts()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateFonts), name: UIAccessibility.boldTextStatusDidChangeNotification, object: nil)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.preferredContentSizeCategory != previousTraitCollection?.preferredContentSizeCategory {
            label2.font = Avenir.light.of(style: .title1)
            label4.font = SystemFont.heavy.of(textStyle: .body)
        }
    }
    
    @objc private func updateFonts() {
        label1.font = Futura.condensedMedium.of(textStyle: .headline, maxSize: 24)
        label2.font = Avenir.light.of(style: .title1)
        label3.font = SystemFont.preferred.of(textStyle: .caption1)
        label4.font = SystemFont.heavy.of(textStyle: .body)
        
        label1.text = label1.font.fontName
        label2.text = label2.font.fontName
        label3.text = label3.font.fontName
        label4.text = label4.font.fontName
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIAccessibility.boldTextStatusDidChangeNotification, object: nil)
    }
}
