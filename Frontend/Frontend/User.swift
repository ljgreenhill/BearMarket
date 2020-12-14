//
//  User.swift
//  Frontend
//
//  Created by Edward on 12/13/20.
//

import UIKit

struct User {
    let id: Int
    let name: String
    let email: String
    let profilePic: UIImageView
    let interested: [Item]
    let selling: [Item]
    let sold: [Item]
    let bought: [Item]
}
