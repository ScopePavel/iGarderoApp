//
//  CreateEntryController.swift
//  iGarderobApp
//
//  Created by Pavel Scope on 31/01/2019.
//  Copyright © 2019 Paronkin Pavel. All rights reserved.
//

import UIKit

class CreateEntryController: UITabBarController {

    @IBOutlet weak var createEntryTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
self.createEntryTextView.text = "dfv"
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
