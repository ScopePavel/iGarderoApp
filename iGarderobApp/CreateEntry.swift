//
//  initionalViewController.swift
//  iGarderobApp
//
//  Created by Pavel Scope on 29/01/2019.
//  Copyright © 2019 Paronkin Pavel. All rights reserved.
//

import UIKit

class initionalViewController: UITabBarController {

   
    @IBOutlet weak var createTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.createTextView.text = "sf"
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
