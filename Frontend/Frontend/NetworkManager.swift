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
    static func getItems(completion: @escaping ([PostDataResponse]) -> Void) {
        let endpoint = "\(host)posts/"
        AF.request(endpoint, method: .get).validate().responseData {
            response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                if let itemsData = try? jsonDecoder.decode(AllPostsResponse.self, from: data)
                {
                    let items = itemsData.data
                    completion(items)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    //logout
    
    //get all active posts
    static func getActiveItems(completion: @escaping ([PostDataResponse]) -> Void) {
        let endpoint = "\(host)/posts/active/"
        AF.request(endpoint, method: .get).validate().responseData {
            response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                if let itemsData = try? jsonDecoder.decode(AllPostsResponse.self, from: data)
                {
                    let activeItems = itemsData.data
                    completion(activeItems)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    //post a post
    static func newPost(title: String, description: String, price: String, image: String, completion: @escaping (PostDataResponse) -> Void) {
        let parameters: Parameters = [
            "title": title,
            "description": description,
            "price": price,
            "image": image
        ]
        let endpoint = "\(host)/posts/"
        AF.request(endpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()

                if let postData = try? jsonDecoder.decode(PostResponse.self, from: data) {
                    let item = postData.data
                    completion(item)
                }

            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

//    post a comment on a post
//    static func newComment(comment: String, completion: @escaping (PostDataResponse) -> Void) {
//        let parameters: Parameters = [
//            //insert parts of comment here
//            "content" : comment
//        ]
//        let endpoint = "\(host)/posts/"
//        AF.request(endpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).validate().responseData { response in
//            switch response.result {
//            case .success(let data):
//                let jsonDecoder = JSONDecoder()
//
//                if let commentData = try? jsonDecoder.decode(CommentsResponse.self, from: data) {
//                    let comment = commentData.data
//                    completion(comment)
//                }
//
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }

    //delete a post //this is absolutely wrong
//    static func deleteItem(id: Int, completion: @escaping (Item) -> Void) -> {
//        let parameters: [String: Any] = [
//            "postId": id
//        ]
//        let endpoint = "\(host)/posts/"
//        AF.request("\(endpoint)\(id)/", method: .delete).validate().responseData {
//            response in
//            case .success(let data):
//                let jsonDecoder = JSONDecoder()
//                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
//                if let item = try? jsonDecoder.decode(Item.self, from: data) //may not be called ItemsDataResponse
//                {
//                    let itemGet = item.data
//                    completion(itemGet)
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
    
    //delete a user
    
    
    //buy an item //What are the parameters of this???????
    static func buyItem(itemId: Int, completion: @escaping (PostDataResponse) -> Void) {
        let parameters: [String: Any] = [
            "id": itemId
        ]
        let endpoint = "\(host)/posts/buy/"
        AF.request("\(endpoint)\(itemId)/", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()

                if let itemsData = try? jsonDecoder.decode(PostResponse.self, from: data) {
                    let items = itemsData.data
                    completion(items)
                }

            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
    //add posts to interested posts
    
    
    //get logged in user
    static func getCurrentUser(completion: @escaping (UserDataResponse) -> Void) {
        let endpoint = "\(host)/users/current/"
        AF.request((endpoint), method: .get).validate().responseData {
            response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                if let user = try? jsonDecoder.decode(UserResponse.self, from: data)
                {
                    let userGet = user.data
                    completion(userGet)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    
    //get user by id
    static func getUserByID(id: String, completion: @escaping (UserDataResponse) -> Void) {
        let endpoint = "\(host)users/" + id
        AF.request(endpoint, method: .get).validate().responseData {
            response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                //jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                if let user = try? jsonDecoder.decode(UserResponse.self, from: data)
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
    static func getItem(id: Int, completion: @escaping (PostDataResponse) -> Void) {
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
                if let item = try? jsonDecoder.decode(PostResponse.self, from: data) //may not be called ItemsDataResponse
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
