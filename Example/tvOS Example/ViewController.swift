//
//  ViewController.swift
//  Swash
//
//  Created by Sam Francis on 9/8/18.
//  Copyright © 2018 Mindgrub. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.font = Avenir.roman.of(textStyle: .title1)
        label.text = label.font.fontName
    }

}

