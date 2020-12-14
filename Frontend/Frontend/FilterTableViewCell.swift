//
//  FilterTableViewCell.swift
//  HackChallenge
//
//  Created by Edward on 12/7/20.
//

import UIKit

class FilterTableViewCell: UITableViewCell {

    var containerView : UIView!
    var filter : UIImageView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        containerView = UIView()
        //add a little more
        containerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(containerView)
        
        //set up to accept an image from the assets
        filter = UIImageView()
        //more
        filter.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(filter)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
        
        NSLayoutConstraint.activate([
            filter.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5),
            filter.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            filter.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            filter.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -5)
        ])
        
    }
}
