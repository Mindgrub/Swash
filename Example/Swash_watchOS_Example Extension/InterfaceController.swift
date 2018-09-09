//
//  InterfaceController.swift
//  Swash_watchOS_Example Extension
//
//  Created by Sam Francis on 9/8/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import WatchKit
import Foundation
import Swash

class InterfaceController: WKInterfaceController {
    
    @IBOutlet weak var label: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        if let font = Avenir.oblique.of(textStyle: .body) {
            let text = NSAttributedString(string: font.fontName,
                                          attributes: [.font: font])
            label.setAttributedText(text)
        }
    }

}
