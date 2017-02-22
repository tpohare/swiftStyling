//
//  StyleableLabel.swift
//  bo
//
//  Created by Tony O' Hare on 22/02/2017.
//  Copyright © 2017 Fusio. All rights reserved.
//

import UIKit

class StyleableLabel:UILabel {
    @IBInspectable var className: String = "" {
        didSet {
            self.setClass(to: self.className)
        }
    }
    
    func setClass(to theClass:String) -> Void {
        self.numberOfLines = 0
        self.attributedText = NSAttributedString(string: self.text!,
                                                 attributes: Class().called(theClass)
        )
    }
    
    func style(withText text:String, andClass theClass:String ) {
        self.text = text
        self.setClass(to: theClass)
    }
}
