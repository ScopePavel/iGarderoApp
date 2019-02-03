//
//  ViewController.swift
//  iGarderobApp
//
//  Created by Pavel Scope on 29/01/2019.
//  Copyright © 2019 Paronkin Pavel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let url = URL(string: "https://bnet.i-partner.ru/testAPI/")!
        
        var reqest = URLRequest(url: url)
        reqest.httpMethod = "POST"
        reqest.setValue("LowTclJ-3i-6IAPxrh", forHTTPHeaderField: "token")
        reqest.setValue("multipart/form-data", forHTTPHeaderField: "Content-Type")
        let parametrs = ["a":"new_session"]
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parametrs, options: []) else { return }
        reqest.httpBody = httpBody
        
        
        let session = URLSession.shared
        
        session.dataTask(with: reqest) { (data, Response , Error) in
            
            if let resp = Response {
                print(resp)
                
            }
            
            
            guard let data = data else { return }
            do {
                let json = try  JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            } catch {
                print(error)
            }
            
        }.resume()
        
    }


}

