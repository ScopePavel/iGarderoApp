//
//  FullEntryViewController.swift
//  iGarderobApp
//
//  Created by Pavel Scope on 30/01/2019.
//  Copyright © 2019 Paronkin Pavel. All rights reserved.
//

import UIKit

class FullEntryViewController: UIViewController {
    
    @IBOutlet weak var EnntryTextView: UITextView!
    var EnntryText: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.EnntryTextView.text = self.EnntryText
    }
    
    
    
}
