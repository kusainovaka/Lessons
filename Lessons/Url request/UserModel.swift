//
//  UserModel.swift
//  Lessons
//
//  Created by Kamila on 10/5/19.
//  Copyright © 2019 Kamila. All rights reserved.
//

import Foundation
// UserDataModel
struct UserModel: Codable {
    var userId: Int
    var id: Int
    var title: String
    var completed: Bool
}

struct Temp {
    var id: Int
    var art: String
    var title: String
    var ratins: Ratings
}

struct Ratings {
    var average: Double
    var votes: Int
}
