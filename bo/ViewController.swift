//
//  ViewController.swift
//  bo
//
//  Created by Tony O' Hare on 15/02/2017.
//  Copyright © 2017 Fusio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var h1: StyleableLabel!
    @IBOutlet weak var p: StyleableLabel!
    @IBOutlet weak var bold: StyleableLabel!
    @IBOutlet weak var italic: StyleableLabel!
    @IBOutlet weak var red: StyleableLabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        //h1.setClass(to: "h1")
        //p.setClass(to: "p")
        //bold.setClass(to: "strong")
    }
}
