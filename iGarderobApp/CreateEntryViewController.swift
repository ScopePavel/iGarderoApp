//
//  CreateEntryViewController.swift
//  iGarderobApp
//
//  Created by Pavel Scope on 31/01/2019.
//  Copyright © 2019 Paronkin Pavel. All rights reserved.
//

import UIKit

class CreateEntryViewController: UIViewController {
    
    @IBOutlet weak var createEntryTextView: UITextView!

    @IBAction func createEntryBarButton(_ sender: UIBarButtonItem) {
        guard let session = UserDefaults.standard.string(forKey: Constant.key),let text = self.createEntryTextView.text else { return }
        if(createEntryTextView.text == "") {
            self.createAlert(message: "Записи нет", title: "Пусто")
        } else {
            ServerManager.shared.addEntry(session: session, body: text) { (_, error) in
                
            }
        }
        self.createAlert(message: "Запись добавлена", title: "Отлично")
    }
    
    @IBAction func deleteEntryBarButtonAction(_ sender: UIBarButtonItem) {
        self.createEntryTextView.text = nil
        createEntryTextView.resignFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        createEntryTextView.resignFirstResponder()
    }
    
    func createAlert(message:String, title:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
}
