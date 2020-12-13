//
//  NewPostViewController.swift
//  HackChallenge
//
//  Created by Edward on 12/11/20.
//

import UIKit

var postTitle : UITextField!
var descript : UITextField!
var titleLabel: UILabel!
var descriptLabel: UILabel!
var postButton: UIButton!
var image: UIImageView!

class NewPostViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "New Post"
        navigationController?.navigationBar.barTintColor = UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1)
        view.backgroundColor = .white
        
        postTitle = UITextField()
        
        descript = UITextField()
        
        titleLabel = UILabel()
        
        descriptLabel = UILabel()
        
        postButton = UIButton()

        image = UIImageView()
    }
    

    

}
