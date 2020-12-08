//
//  MePageViewController.swift
//  HackChallenge
//
//  Created by Edward on 12/7/20.
//

import UIKit

class MePageViewController: UIViewController {

    var tagTableView: UITableView!
    var postsCollectionView: UICollectionView!
    var userName: UILabel!
    var email: UILabel!
    var bio: UITextView!
    var profilePic: UIImageView!
    
    let itemCellReuseIdentifier = "itemCellReuseIdentifier"
    let padding: CGFloat = 8
    let tabHeight: CGFloat = 40
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Me"
        view.backgroundColor = .white
        
        //Tag Table View
        tagTableView = UITableView()
        tagTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tagTableView)
        
        //Posts Collection View
        postsCollectionView = UICollectionView()
        postsCollectionView.delegate = self
        postsCollectionView.dataSource = self
        postsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        postsCollectionView.separatorStyle = .none
        postsCollectionView.backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 1)
        postsCollectionView.register(ItemCollectionViewCell.self, forCellReuseIdentifier: itemCellReuseIdentifier)
        view.addSubview(postsCollectionView)
        
        //Other
        
        setupConstraints()
    }


    private func setupConstraints() {
        NSLayoutConstraint.activate([])
    }
    
    @objc func presentItemViewController() {
        let vc = itemViewController(delegate: self, titleString: ???idkWhatItIsCalled??.titleLabel?.text)
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }

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

