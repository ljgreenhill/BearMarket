//
//  NetworkManager.swift
//  Frontend
//
//  Created by Edward on 12/13/20.
//

import Alamofire
import Foundation

class NetworkManager {

    private static let host = "https://bear-market.herokuapp.com/"
    
    //get all posts
    static func getItems(completion: @escaping ([Item]) -> Void) {
        let endpoint = "\(host)/posts/"
        AF.request(endpoint, method: .get).validate().responseData {
            response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                if let itemsData = try? jsonDecoder.decode(ItemsDataResponse.self, from: data) //may not be called ItemsDataResponse
                {
                    let items = itemsData.items
                    completion(items)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    //logout
    
    //get all active posts
    static func getActiveItems(completion: @escaping ([Item]) -> Void) {
        let endpoint = "\(host)/posts/active/"
        AF.request(endpoint, method: .get).validate().responseData {
            response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                if let itemsData = try? jsonDecoder.decode(ActiveItemsDataResponse.self, from: data) //may not be called ActiveItemsDataResponse
                {
                    let activeItems = itemsData.items
                    completion(activeItems)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    //post a post
    static func newPost(item: Item, completion: @escaping (Item) -> Void) {
        let parameters: Parameters = [
            //insert parts of Item here
        ]
        let endpoint = "\(host)/posts/"
        AF.request(endpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                
                if let courseData = try? jsonDecoder.decode(Response<Item>.self, from: data) {
                    let items = itemsData.data
                    completion(items)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    //post a comment on a post
    static func newComment(comment: String, completion: @escaping (Item) -> Void) {
        let parameters: Parameters = [
            insert parts of comment here
            "comments" : comment
        ]
        let endpoint = "\(host)/posts/"
        AF.request(endpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                
                if let courseData = try? jsonDecoder.decode(Response<Item>.self, from: data) {
                    let items = itemsData.data
                    completion(items)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    //delete a post //this is absolutely wrong
    static func deleteItem(id: Int, completion: @escaping (Item) -> Void) -> {
        let parameters: [String: Any] = [
            "postId": id
        ]
        let endpoint = "\(host)/posts/"
        AF.request("\(endpoint)\(id)/", method: .delete).validate().responseData {
            response in
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                if let item = try? jsonDecoder.decode(Item.self, from: data) //may not be called ItemsDataResponse
                {
                    let itemGet = item.data
                    completion(itemGet)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    //delete a user
    
    
    //buy an item //What are the parameters of this???????
    static func buyItem(itemId: Int, userId: String, completion: @escaping (Item) -> Void) {
        let parameters: Parameters = [
            //idk
        ]
        AF.request("\(host)/posts/\(itemId)", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                
                if let courseData = try? jsonDecoder.decode(Response<Item>.self, from: data) {
                    let items = itemsData.data
                    completion(items)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        AF.request(endpoint)
    }
    
    //add posts to interested posts
    
    
    //get logged in user
    
    
    //get user by id
    static func getUserByID(id: String, completion: @escaping (Item) -> Void) {
        let parameters: [String: Any] = [
            "userId": id
        ]
        let endpoint = "\(host)/users/"
        AF.request("\(endpoint)\(id)/", method: .get).validate().responseData {
            response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                if let user = try? jsonDecoder.decode(User.self, from: data)
                {
                    let userGet = user.data
                    completion(userGet)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    //get post by id
    static func getItem(id: Int, completion: @escaping ([Item]) -> Void) {
        let parameters: [String: Any] = [
            "postId": id
        ]
        let endpoint = "\(host)/posts/"
        AF.request("\(endpoint)\(id)/", method: .get).validate().responseData {
            response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                if let item = try? jsonDecoder.decode(Item.self, from: data) //may not be called ItemsDataResponse
                {
                    let itemGet = item.data
                    completion(itemGet)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    //get all users
}