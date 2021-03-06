//
//  MePageViewController.swift
//  HackChallenge
//
//  Created by Edward on 12/7/20.
//

import UIKit

class MePageViewController: UIViewController {

    
    private var tagTableView: UITableView!
    private var itemCollectionView: UICollectionView!
    private var userName: UILabel!
    private var email: UILabel!
    private var bio: UITextView!
    private var profilePic: UIImageView!
    private var addPostButton: UIButton!
    private var profileView: UIView!
    
    private let itemCellReuseIdentifier = "itemCellReuseIdentifier"
    private let tagCellReuseIdentifier = "tagCellReuseIdentifier"
    private let padding: CGFloat = 8
    private let tabHeight: CGFloat = 40
    
    private let sellTag = Tag(name: "Selling")
    private let interestTag = Tag(name: "Interested")
    private let buyTag = Tag(name: "Bought")
    private var tags: [Tag]!
    
    private var items: [PostDataResponse] = []
    private var sellItems: [PostDataResponse] = []
    private var buyItems: [PostDataResponse] = []
    private var interestItems: [PostDataResponse] = []
    private var profile: UserDataResponse!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "My Profile"
        navigationController?.navigationBar.barTintColor = UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1)
        view.backgroundColor = .white
        
        tags = [sellTag, interestTag, buyTag]
        
        if let selling = profile.selling {
            sellItems = selling
        }
        if let interested = profile.interested {
            interestItems = interested
        }
        buyItems = profile.bought
        
        //Profile
        profileView = UIView()
        profileView.layer.cornerRadius = 20
        profileView.layer.backgroundColor = UIColor.white.cgColor
        profileView.clipsToBounds = true
        profileView.layer.masksToBounds = true
        profileView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(profileView)
        
        userName = UILabel()
        userName.text = profile.name
        userName.translatesAutoresizingMaskIntoConstraints = false
        profileView.addSubview(userName)
        
        email = UILabel()
        email.text = profile.email
        email.translatesAutoresizingMaskIntoConstraints = false
        profileView.addSubview(email)
        
        let photoURL = URL(string: profile.profile_pic)
        profilePic = UIImageView()
        profilePic.translatesAutoresizingMaskIntoConstraints = false
        profileView.addSubview(profilePic)
        
        //Other
        addPostButton = UIButton()
        addPostButton.tintColor = .blue
        addPostButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addPostButton)
        
        //Tag Table View
        tagTableView = UITableView()
        tagTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tagTableView)
        
        //Posts Collection View
        /**itemCollectionView = UICollectionView()
         itemCollectionView.delegate = self
         itemCollectionView.dataSource = self
        itemCollectionView.translatesAutoresizingMaskIntoConstraints = false
        itemCollectionView.separatorStyle = .none
        itemCollectionView.backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 1)
        itemCollectionView.register(ItemCollectionViewCell.self, forCellReuseIdentifier: itemCellReuseIdentifier)
        view.addSubview(itemCollectionView)*/
        
        //a5 version
        let postsLayout = UICollectionViewFlowLayout()
        postsLayout.minimumInteritemSpacing = padding
        postsLayout.minimumLineSpacing = padding
        postsLayout.scrollDirection = .vertical
        
        
        itemCollectionView = UICollectionView(frame: .zero, collectionViewLayout: postsLayout)
        itemCollectionView.dataSource = self
        itemCollectionView.backgroundColor = .white
        itemCollectionView.translatesAutoresizingMaskIntoConstraints = false
        itemCollectionView.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier: itemCellReuseIdentifier)
//        itemCollectionView.dataSource = self
        itemCollectionView.delegate = self
        view.addSubview(itemCollectionView)
        
        getCurrentUser()
        getItems()
        setupConstraints()
    }


    private func setupConstraints() {
        NSLayoutConstraint.activate([
            profileView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            profileView.heightAnchor.constraint(equalToConstant: 200),
            profileView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            userName.topAnchor.constraint(equalTo: profileView.safeAreaLayoutGuide.topAnchor, constant: 5),
            userName.heightAnchor.constraint(equalToConstant: 25),
            userName.leadingAnchor.constraint(equalTo: profileView.leadingAnchor),
            userName.trailingAnchor.constraint(equalTo: profileView.trailingAnchor),
            userName.centerXAnchor.constraint(equalTo: profileView.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            profilePic.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 5),
            profilePic.heightAnchor.constraint(equalToConstant: 50),
            profilePic.leadingAnchor.constraint(equalTo: profileView.leadingAnchor),
            profilePic.trailingAnchor.constraint(equalTo: profileView.trailingAnchor),
            profilePic.centerXAnchor.constraint(equalTo: profileView.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            email.topAnchor.constraint(equalTo: profilePic.bottomAnchor, constant: 30),
            email.heightAnchor.constraint(equalToConstant: 30),
            email.leadingAnchor.constraint(equalTo: profileView.leadingAnchor),
            email.trailingAnchor.constraint(equalTo: profileView.trailingAnchor),
            email.centerXAnchor.constraint(equalTo: profileView.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            tagTableView.topAnchor.constraint(equalTo: profileView.bottomAnchor, constant: 10),
            tagTableView.heightAnchor.constraint(equalToConstant: 50),
            tagTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tagTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            itemCollectionView.topAnchor.constraint(equalTo: tagTableView.bottomAnchor, constant: 10),
            itemCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            itemCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            itemCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    /*@objc func presentPostViewController() {
        let vc = itemViewController(delegate: self, titleString: itemCollectionView.cellForItem(at: <#T##IndexPath#>).titleLabel?.text)
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }*/
    
    //get info for current user
    private func getCurrentUser() {
        NetworkManager.getCurrentUser{ user in
            self.profile = user
        }
        DispatchQueue.main.async {
            self.itemCollectionView.reloadData()
        }
    }
    


    func getItems() {
        
        NetworkManager.getItems { items in
            self.items = items
            
            DispatchQueue.main.async{
                self.itemCollectionView.reloadData()
            }
        }
    }

//    func getUsers() {
//        NetworkManager.getUserByID(id: items[].seller, completion: <#T##(UserDataResponse) -> Void#>)
//
//    }
}

extension MePageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
}

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: itemCellReuseIdentifier, for: indexPath) as! ItemCollectionViewCell
        let item = items[indexPath.row]
        cell.configure(item: item)
        return cell
    }
}

extension MePageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tags.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tagTableView.dequeueReusableCell(withIdentifier: tagCellReuseIdentifier, for: indexPath) as! FilterTableViewCell
        let tag = tags[indexPath.row]
        cell.configure(tag: tag)
        return cell
    }
    
}

extension MePageViewController: UICollectionViewDelegateFlowLayout {

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let size = (collectionView.frame.width)/2
    return CGSize(width: size, height: 1.5 * size)
}

}

extension MePageViewController: UICollectionViewDelegate {

func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let item = items[indexPath.row]
    let postViewController = PostViewController(post: item)
    navigationController?.pushViewController(postViewController, animated: true)
}
}
