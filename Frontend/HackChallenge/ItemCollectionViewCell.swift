//
//  ItemCollectionViewCell.swift
//  HackChallenge
//
//  Created by Peter Huo on 11/30/20.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {
    
    let containerView = UIView()
    let itemImageView = UIImageView()
    let itemNameLabel = UILabel()
    let userNameLabel = UILabel()
    let userImageView = UIImageView(frame: CGRect(x:0, y:0, width:25, height:25))
    let priceLabel = UILabel()
    //let starButton = UIButton()
    //let starCountLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
        
        containerView.layer.cornerRadius = 10
        containerView.layer.backgroundColor = UIColor.white.cgColor
        containerView.clipsToBounds = true
        containerView.layer.masksToBounds = true
        containerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(containerView)
        
        itemImageView.translatesAutoresizingMaskIntoConstraints = false
        itemImageView.clipsToBounds = true
        itemImageView.layer.masksToBounds = true
        itemImageView.contentMode = .scaleAspectFill
        containerView.addSubview(itemImageView)
        
        priceLabel.backgroundColor = .gray
        priceLabel.textColor = .white
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.font = .boldSystemFont(ofSize: 11)
        containerView.addSubview(priceLabel)
        
        itemNameLabel.textColor = .black
        itemNameLabel.translatesAutoresizingMaskIntoConstraints = false
        itemNameLabel.font = .boldSystemFont(ofSize: 18)
        containerView.addSubview(itemNameLabel)
        
        userNameLabel.textColor = .black
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.font = .systemFont(ofSize: 10)
        containerView.addSubview(userNameLabel)
        
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        userImageView.clipsToBounds = true
        userImageView.layer.masksToBounds = true
        //userImageView.contentMode = .scaleAspectFill
        userImageView.layer.borderWidth = 1.0
        //userImageView.layer.masksToBounds = false
        userImageView.layer.cornerRadius = userImageView.frame.size.width/2
        containerView.addSubview(userImageView)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints(){
        //let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant:10),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            itemImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            itemImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            itemImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            itemImageView.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        NSLayoutConstraint.activate([
            //priceLabel.topAnchor.constraint(equalTo: itemNameLabel.topAnchor, constant: -30),
            priceLabel.heightAnchor.constraint(equalToConstant: 18),
            priceLabel.bottomAnchor.constraint(equalTo: itemImageView.bottomAnchor),
            priceLabel.widthAnchor.constraint(equalToConstant: 40),
            //priceLabel.leadingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            priceLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            itemNameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 145),
            itemNameLabel.leadingAnchor.constraint(equalTo: itemImageView.leadingAnchor, constant: 6),
            itemNameLabel.trailingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: -6),
            itemNameLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant:-30)
        ])
        
        NSLayoutConstraint.activate([
            userImageView.topAnchor.constraint(equalTo: itemNameLabel.bottomAnchor, constant: -5),
            userImageView.heightAnchor.constraint(equalToConstant:25),
            userImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 6),
            userImageView.widthAnchor.constraint(equalToConstant:25),
            //userImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -90),
            userImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            userNameLabel.topAnchor.constraint(equalTo: itemNameLabel.bottomAnchor, constant: 0.5),
            userNameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 37),
            userNameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            userImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
    func configure(item: Item) {
        itemImageView.image = UIImage(named: item.itemImage)
        itemNameLabel.text = item.itemName
        userImageView.image = UIImage(named: item.userImage)
        userNameLabel.text = item.userName
        priceLabel.text = "$" + item.price
    }
}

