//
//  MePageViewController.swift
//  HackChallenge
//
//  Created by Edward on 12/7/20.
//

import UIKit

class MePageViewController: UIViewController {

    var tagTableView: UITableView!
    var itemCollectionView: UICollectionView!
    var userName: UILabel!
    var email: UILabel!
    var bio: UITextView!
    var profilePic: UIImageView!
    var addPostButton: UIButton!
    var profileView: UIView!
    
    let itemCellReuseIdentifier = "itemCellReuseIdentifier"
    let padding: CGFloat = 8
    let tabHeight: CGFloat = 40
    
    var tags: [UIImageView]! //delete later
    //delete later
    let item1 = Item(itemImage: "item1", itemName: "First Item", userImage: "user1", userName: "First User", price: "34.99")
    let item2 = Item(itemImage: "item2", itemName: "Second Item", userImage: "user2", userName: "Second User", price: "20.00")
    var items: [Item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Me"
        navigationController?.navigationBar.barTintColor = UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1)
        view.backgroundColor = .white
        
        items = [item1, item2, item1, item2, item1, item2]
        
        //Profile
        profileView = UIView()
        view.addSubview(profileView)
        
        userName = UILabel()
        userName.text = "Rachel"
        userName.translatesAutoresizingMaskIntoConstraints = false
        profileView.addSubview(userName)
        
        email = UILabel()
        email.text = "rachel@mail.com"
        email.translatesAutoresizingMaskIntoConstraints = false
        profileView.addSubview(email)
        
        bio = UITextView()
        bio.text = "this is me"
        bio.translatesAutoresizingMaskIntoConstraints = false
        profileView.addSubview(bio)
        
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
        itemCollectionView.backgroundColor = .white
        itemCollectionView.translatesAutoresizingMaskIntoConstraints = false
        itemCollectionView.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier: itemCellReuseIdentifier)
        itemCollectionView.dataSource = self
        itemCollectionView.delegate = self
        view.addSubview(itemCollectionView)
        
        
        setupConstraints()
    }


    private func setupConstraints() {
        NSLayoutConstraint.activate([
            profileView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            profileView.heightAnchor.constraint(equalToConstant: 200),
            profileView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            userName.topAnchor.constraint(equalTo: profileView.safeAreaLayoutGuide.topAnchor, constant: 30),
            userName.heightAnchor.constraint(equalToConstant: 30),
            userName.leadingAnchor.constraint(equalTo: profileView.leadingAnchor),
            userName.trailingAnchor.constraint(equalTo: profileView.trailingAnchor),
            userName.centerXAnchor.constraint(equalTo: profileView.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            profilePic.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 30),
            profilePic.heightAnchor.constraint(equalToConstant: 60),
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
    
    /**@objc func presentItemViewController() {
        let vc = itemViewController(delegate: self, titleString: ???idkWhatItIsCalled??.titleLabel?.text)
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }*/

}

extension MePageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: itemCellReuseIdentifier, for: indexPath) as! ItemCollectionViewCell
        cell.configure(item: items[indexPath.row])
        return cell
    }
}

extension MePageViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.width)/2
        return CGSize(width: size, height: 1.5 * size)
    }
    
}

