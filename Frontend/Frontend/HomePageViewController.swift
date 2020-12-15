//
//  MainViewViewController.swift
//  HackChallenge
//
//  Created by Peter Huo on 12/8/20.
//

import UIKit


class HomePageViewController: UIViewController {
    
    var itemCollectionView: UICollectionView!
    let searchBar = UISearchBar()
//    private let filter = UIImageView()
    let itemReuseIdentifier = "ItemReuseIdentifier"
    let padding = CGFloat(5)
    
    //this part will be deleted after connecting to backend
//    let item1 = Item(itemImage: "item1", itemName: "First Item", userImage: "user1", userName: "First User", price: "34.99")
//    let item2 = Item(itemImage: "item2", itemName: "Second Item", userImage: "user2", userName: "Second User", price: "20.00")
    var items: [PostDataResponse] = []
    //var users: [UserDataResponse] = []


    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1)
        view.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
        title = "Bear Market"
        
        //this part will be deleted after connecting to backend
//        items = [item1, item2, item1, item2, item1, item2]
        
        //searchBar.delegate = self
        searchBar.backgroundColor = .white
        searchBar.backgroundImage = UIImage()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Search"
        searchBar.searchTextField.backgroundColor = .white
        searchBar.searchTextField.textColor = .black
        searchBar.searchTextField.font = .systemFont(ofSize: 14)
        searchBar.searchTextField.clearButtonMode = .never
        searchBar.layer.cornerRadius = 5
        searchBar.layer.masksToBounds = true
        view.addSubview(searchBar)
        
//        filter.image = UIImage(named: "filter")
//        filter.clipsToBounds = true
//        filter.layer.masksToBounds = true
//        //filter.contentMode = .scaleAspectFill
//        filter.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(filter)
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = -10
        layout.scrollDirection = .vertical
        itemCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        itemCollectionView.delegate = self
        itemCollectionView.dataSource = self
        itemCollectionView.translatesAutoresizingMaskIntoConstraints = false
        itemCollectionView.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
        itemCollectionView.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier: itemReuseIdentifier)
        view.addSubview(itemCollectionView)
        
        getItems()
        //getUsers()
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            searchBar.heightAnchor.constraint(equalToConstant: 35)
        ])
        
//        NSLayoutConstraint.activate([
//            filter.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
//            filter.leadingAnchor.constraint(equalTo: searchBar.trailingAnchor, constant: 9),
//            filter.widthAnchor.constraint(equalToConstant: 35),
//            //filter.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant:10),
//            filter.heightAnchor.constraint(equalToConstant: 28)
//        ])
        
        NSLayoutConstraint.activate([
            itemCollectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            itemCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            itemCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            itemCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func getItems() {
        
        NetworkManager.getItems { items in
            self.items = items
//            for x in 0..<self.items.count {
//                NetworkManager.getUserByID(id: self.items[x].seller) { user in
//                    self.users.append(user)
//                }
//            }
            DispatchQueue.main.async{
                self.itemCollectionView.reloadData()
            }
        }
    }
    
//    func getUsers() {
//        NetworkManager.getUserByID(id: , completion: )
//
//    }
}

extension HomePageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: itemReuseIdentifier, for: indexPath) as! ItemCollectionViewCell
        let item = items[indexPath.row]
       // let user = users[indexPath.row]
        cell.configure(item: item)
        return cell
    }
}

extension HomePageViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.width)/2
        return CGSize(width: size, height: 1.5 * size)
    }
    
}

extension HomePageViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        let postViewController = PostViewController(post: item)
        navigationController?.pushViewController(postViewController, animated: true)
    }
}
