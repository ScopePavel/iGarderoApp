//
//  EntrysTableViewController.swift
//  iGarderobApp
//
//  Created by Pavel Scope on 29/01/2019.
//  Copyright © 2019 Paronkin Pavel. All rights reserved.
//

import Foundation

class ServerManager: NSObject {
    typealias GetModelClosure = (_ model: UserListsModel?, _ error: Error?) -> Void
    typealias GetSessionModelClosure = (_ model: Session?, _ error: Error?) -> Void
    typealias GetNewIdClosure = (_ id: Int?, _ error: Error?) -> Void
    typealias GetResultClosure = (_ id: Bool?, _ error: Error?) -> Void
    
    static let shared = ServerManager()
    private override init() {}
    
    let apiKey = "LowTclJ-3i-6IAPxrh"
    let urlString = "https://bnet.i-partner.ru/testAPI/"
    
    func createNewSession(completion: @escaping GetSessionModelClosure) {
        let url = URL(string: urlString)!
        var reqest = URLRequest(url: url)
        reqest.httpMethod = "POST"
        reqest.addValue(self.apiKey, forHTTPHeaderField: "token")
        let head = "a=new_session"
        let parametrs = head.data(using: .utf8)
        reqest.httpBody = parametrs
        let session = URLSession.shared
        session.dataTask(with: reqest) { (data, Response , Error) in
            if let resp = Response {
                print(resp)
            }
            guard let data = data else { return  }
            do {
                
                let sessionResponse = try JSONDecoder().decode(SessionResponse.self, from: data)
                completion(sessionResponse.data, nil)
                
            } catch {
                completion(nil, error)
            }
            }.resume()
    }
    
    func getEntries(session: String, completion: @escaping GetModelClosure) {
        let url = URL(string: urlString)!
        var reqest = URLRequest(url: url)
        reqest.httpMethod = "POST"
        reqest.addValue(apiKey, forHTTPHeaderField: "token")
        let str = "a=get_entries&session=\(session)"
        let parametrs = str.data(using: .utf8)
        reqest.httpBody = parametrs
        let session = URLSession.shared
        session.dataTask(with: reqest) { (data, Response , Error) in
            if let resp = Response {
                print(resp)
            }
            guard let data = data else { return }
            do {
                let model = try  JSONDecoder().decode(UserListsModel.self, from: data)
                completion(model, nil)
            } catch {
                completion(nil, error)
            }
            }.resume()
    }
    
    func addEntry(session: String, body:String, completion: @escaping GetNewIdClosure) {
        let url = URL(string: urlString)!
        var reqest = URLRequest(url: url)
        reqest.httpMethod = "POST"
        reqest.addValue(apiKey, forHTTPHeaderField: "token")
        let str = "a=add_entry&session=\(session)&body=\(body)"
        let parametrs = str.data(using: .utf8)
        reqest.httpBody = parametrs
        let session = URLSession.shared
        session.dataTask(with: reqest) { (data, Response , Error) in
            if let resp = Response {
                print(resp)
            }
            guard let data = data else { return }
            do {
                let id = try  JSONDecoder().decode(Int.self, from: data)
                completion(id, nil)
            } catch {
                completion(nil, error)
            }
            }.resume()
    }
    
    func editEntry(session: String, completion: @escaping GetResultClosure) {
        let url = URL(string: urlString)!
        var reqest = URLRequest(url: url)
        reqest.httpMethod = "POST"
        reqest.addValue(apiKey, forHTTPHeaderField: "token")
        let str = "a=edit_entry"
        let parametrs = str.data(using: .utf8)
        reqest.httpBody = parametrs
        let session = URLSession.shared
        session.dataTask(with: reqest) { (data, Response , Error) in
            if let resp = Response {
                print(resp)
            }
            guard let data = data else { return }
            do {
                let result = try  JSONDecoder().decode(Bool.self, from: data)
                completion(result, nil)
            } catch {
                completion(nil, error)
            }
            }.resume()
    }
    
    func removeEntry(session: String, completion: @escaping GetResultClosure) {
        let url = URL(string: urlString)!
        var reqest = URLRequest(url: url)
        reqest.httpMethod = "POST"
        reqest.addValue(apiKey, forHTTPHeaderField: "token")
        let str = "a=remove_entry"
        let parametrs = str.data(using: .utf8)
        reqest.httpBody = parametrs
        let session = URLSession.shared
        session.dataTask(with: reqest) { (data, Response , Error) in
            if let resp = Response {
                print(resp)
            }
            guard let data = data else { return }
            do {
                let result = try  JSONDecoder().decode(Bool.self, from: data)
                completion(result, nil)
            } catch {
                completion(nil, error)
            }
            }.resume()
    }
}
