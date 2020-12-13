//
//  User.swift
//  HackChallenge
//
//  Created by Rachel on 12/9/20.
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

