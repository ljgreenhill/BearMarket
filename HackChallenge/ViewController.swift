//
//  ViewController.swift
//  HackChallenge
//
//  Created by Peter Huo on 11/25/20.
//

import UIKit

class ViewController: UIViewController {
    
    let searchBar = UISearchBar()
    var itemCollectionView: UICollectionView!
    let itemReuseIdentifier = "ItemReuseIdentifier"
    let padding = CGFloat(5)
    
    //this part will be deleted after connecting to backend
    let item1 = Item(itemImage: "item1", itemName: "First Item", userImage: "user1", userName: "First User")
    let item2 = Item(itemImage: "item2", itemName: "Second Item", userImage: "user2", userName: "Second User")
    var items: [Item] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1)
        view.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
        title = "Bear Market"
        
        //this part will be deleted after connecting to backend
        items = [item1, item2, item1, item2, item1, item2]
        
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
        
        setupConstraints()
        
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -55),
            searchBar.heightAnchor.constraint(equalToConstant: 35)
        ])
        
        NSLayoutConstraint.activate([
            itemCollectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            itemCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            itemCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            itemCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: itemReuseIdentifier, for: indexPath) as! ItemCollectionViewCell
        cell.configure(item: items[indexPath.row])
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.width)/2
        return CGSize(width: size, height: 1.5 * size)
    }
    
}
