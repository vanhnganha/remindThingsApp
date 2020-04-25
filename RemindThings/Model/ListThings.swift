//
//  ListThings.swift
//  RemindThings
//
//  Created by NganHa on 4/21/20.
//  Copyright © 2020 Galaxy. All rights reserved.
//

import Foundation
import Firebase
struct ListThings {
    var id: String
    var name: String
    var color: String
    var isDeleted: Bool
    var listChild: Array<String>?
}
