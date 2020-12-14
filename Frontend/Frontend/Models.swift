//
//  Models.swift
//  Frontend
//
//  Created by Peter Huo on 12/13/20.
//

import Foundation

struct AllPostsResponse: Codable{
    var success: Bool
    var data: [PostDataResponse]
}

struct PostDataResponse: Codable{
    var id: Int
    var title: String
    var description: String
    var active: Bool
    var price: String
    var seller: String
    var buyer: String?
    var image: String
    var comments: [CommentsResponse]?
}

struct CommentsResponse: Codable {
    var id: Int
    var sender: String
    var content: String
}

struct PostResponse: Codable{
    var success: Bool
    var data: PostDataResponse
}

struct UserResponse: Codable {
    var success: Bool
    var data: UserDataResponse
}

struct UserDataResponse: Codable {
    var id: String
    var name: String
    var email: String
    var profile_pic: String
    var interested: [PostDataResponse]?
    var selling: [PostDataResponse]?
    var sold: [PostDataResponse]
    var bought: [PostDataResponse]
}
