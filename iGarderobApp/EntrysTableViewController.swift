//
//  EntrysTableViewController.swift
//  iGarderobApp
//
//  Created by Pavel Scope on 29/01/2019.
//  Copyright © 2019 Paronkin Pavel. All rights reserved.
//

import UIKit
import SystemConfiguration

struct Constant {
    static let key: String = "Key"
}

class EntrysTableViewController: UITableViewController {
    
    var sessionId : String = ""
    var body: String = ""
    var userLists : UserListsModel?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !self.isInternetAvailable() {
            self.callAlerts(title: "Сеть", message: "нет подключения")
        } else {
            guard let session = UserDefaults.standard.string(forKey: Constant.key) else {
                ServerManager.shared.createNewSession { (session, error) in
                    guard let session = session else { return }
                    UserDefaults.standard.set(session.session, forKey: Constant.key)
                    self.sessionId = session.session
                    self.fillTableView(session.session)
                }
                return
            }
            self.fillTableView(session)
        }
    }
    
    func fillTableView(_ session: String) {
        
        ServerManager.shared.getEntries(session: session) { [weak self] (userLists, error) in
            self?.userLists = userLists
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = self.userLists?.data.first?.count else { return 0 }
        return count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: "Identifier2", for: indexPath)
        guard let cell = dequeuedCell as? CustomCell else {
            return dequeuedCell
        }
        let info = self.userLists?.data.first?[indexPath.row]
        guard   let dateStringDa = info?.da,
            let dateStringDm = info?.dm,
            let dateDoubleDa = Double(dateStringDa),
            let dateDoubleDm = Double(dateStringDm),
            let body         = info?.body
            else {
                return UITableViewCell()
        }
        let dmString = createDateString(dateDouble: dateDoubleDm)
        let daString = createDateString(dateDouble: dateDoubleDa)
        cell.daLabel.text = "da: \(daString)"
        if(dateDoubleDm != dateDoubleDa) {
            cell.dmLabel.text = "dm: \(dmString)"
        } else {
            cell.dmLabel.text = nil
        }
        if (body.count > 200) {
            let prefixString =  body.prefix(200) + "..."
            cell.enbtryLabel.numberOfLines = 4
            cell.enbtryLabel.text = String(prefixString)
        } else {
            cell.enbtryLabel.numberOfLines = 4
            cell.enbtryLabel.text = body
        }
        return cell
    }
    
    func createDateString(dateDouble:Double) -> String {
        let date = Date(timeIntervalSince1970: dateDouble)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let formatDateString = formatter.string(from: date)
        return formatDateString
    }
    
    // MARK: ----UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let contentVC = storyboard.instantiateViewController(withIdentifier: "FullEntryViewController") as? FullEntryViewController else {
            return
        }
        let info = self.userLists?.data.first?[indexPath.row]
        guard let body = info?.body else { return }
        let prefixString =  body.prefix(200) + "..."
        print(String(prefixString))
        contentVC.EnntryText = body
        self.navigationController?.pushViewController(contentVC, animated: true)
    }
    
    // MARK: - Alerts
    
    func callAlerts(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionAlertOne = UIAlertAction(title: "Попробовать снова", style: .default, handler: { (actionAlert) in
            if (!self.isInternetAvailable()) {
                alertController.dismiss(animated: false, completion: { [weak self] in
                    self?.callAlerts(title: "Сеть", message: "нет подключенияb")
                })
                self.callAlerts(title: "Сеть", message: "нет подключения")
            } else {
                guard let session = UserDefaults.standard.string(forKey: Constant.key) else {
                    ServerManager.shared.createNewSession { (session, error) in
                        guard let session = session else { return }
                        UserDefaults.standard.set(session.session, forKey: Constant.key)
                        self.sessionId = session.session
                        self.fillTableView(session.session)
                    }
                    return
                }
                self.fillTableView(session)
            }
        })
        
        let actionAlertTwo = UIAlertAction(title: "Выйти", style: .default, handler: { (actionAlert) in
            UIControl().sendAction(#selector(URLSessionTask.suspend), to: UIApplication.shared, for: nil)
        })
        alertController.addAction(actionAlertOne)
        alertController.addAction(actionAlertTwo)
        self.present(alertController, animated: true, completion: nil)
        print(" ! Network error")
    }

    //MARK: - InternetAvailable
    
    private func isInternetAvailable() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return (isReachable && !needsConnection)
    }
    
}
