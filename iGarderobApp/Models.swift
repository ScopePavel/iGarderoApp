//
//  EntrysTableViewController.swift
//  iGarderobApp
//
//  Created by Pavel Scope on 29/01/2019.
//  Copyright © 2019 Paronkin Pavel. All rights reserved.
//

import Foundation

public struct SessionResponse: Decodable {
    var status: Int?
    var data: Session
    
    enum CodingKeys: String, CodingKey {
        case status
        case data
    }
}

public struct Session: Decodable {
    var session: String
    
    enum CodingKeys: String, CodingKey {
        case session
    }
}

struct UserListsModel: Decodable {
    var data: [[UserListModel]]
    
    enum CodingKeys: String, CodingKey {
        case data
    }
}

struct UserListModel: Decodable {
    var id: String
    var body: String
    var da: String
    var dm: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case body
        case da
        case dm
    }
}
