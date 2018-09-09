//
//  ViewController.swift
//  Swash_tvOS_Example
//
//  Created by Sam Francis on 9/8/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import Swash

class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.font = Avenir.roman.of(textStyle: .title1)
        label.text = label.font.fontName
    }


}

