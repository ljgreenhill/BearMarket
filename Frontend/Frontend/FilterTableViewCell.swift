//
//  FilterTableViewCell.swift
//  HackChallenge
//
//  Created by Edward on 12/7/20.
//

import UIKit

class FilterTableViewCell: UITableViewCell {

    var name : UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.font = UIFont.systemFont(ofSize: 15)
        name.textAlignment = .center
        name.textColor = .red
        contentView.addSubview(name)
        
        setupConstraints()
    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            name.topAnchor.constraint(equalTo: contentView.topAnchor),
            name.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            name.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            name.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            name.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    override var isSelected: Bool {
        didSet{
            if self.isSelected{
                self.backgroundColor = .red
                name.textColor = .white
            } else {
                self.backgroundColor = .white
                name.textColor = .red
            }
        }
    }
    
//    func configure(tag: Tag) {
//        name.text = tag.name
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
