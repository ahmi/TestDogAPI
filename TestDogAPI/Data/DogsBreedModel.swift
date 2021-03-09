//
//  BreedModel.swift
//  TestDogAPI
//
//  Created by Ahmad Waqas on 23/2/21.
//

import UIKit

public struct DogsBreedModel: Codable {
    var message: String?
    var status: String?
    
    init(message: String, status: String) {
        self.message = message
        self.status = status
    }
}

public struct DogsBreedListModel: Codable, Hashable {
    var message: [String: [String]]?
    var status: String?
    
    init(message: [String: [String]]?, status: String?) {
        self.message = message
        self.status = status
    }
}
