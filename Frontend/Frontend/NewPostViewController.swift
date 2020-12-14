//
//  NewPostViewController.swift
//  Frontend
//
//  Created by Edward on 12/13/20.
//

import UIKit

var postTitle : UITextField!
var descript : UITextField!
var titleLabel: UILabel!
var descriptLabel: UILabel!
var postButton: UIBarButtonItem!
var imageButton: UIButton!
var imageView: UIImageView!
var image: UIImage?

class NewPostViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "New Post"
        navigationController?.navigationBar.barTintColor = UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1)
        view.backgroundColor = .white
        
        postTitle = UITextField()
        postTitle.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(postTitle)
        
        descript = UITextField()
        descript.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(descript)
        
        titleLabel = UILabel()
        titleLabel.text = "Post Title:"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        descriptLabel = UILabel()
        descriptLabel.text = "Description:"
        descriptLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(descriptLabel)
        
        postButton = UIBarButtonItem(title: "Post", style: .plain, target: self, action: #selector(createNewPost))
        navigationItem.rightBarButtonItem = postButton
        
        imageButton = UIButton()
        imageButton.setTitle("Select Image", for: .normal)
        imageButton.setTitleColor(.red, for: .normal)
        imageButton.addTarget(self, action: #selector(pushImagePicker), for: .touchUpInside)
        imageButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageButton)

        imageView = UIImageView(image: image?)
        imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        
        
        image = UIImage()?
        image.translatesAutoresizingMaskIntoConstraints = false
        imageView.addSubview(image)
        
    }
    
    
    @objc pushImagePicker() {
        let vc = ImagePickerViewController(delegate: self, titleString: imageButton.titleLabel?.text)
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc func createNewPost() {
        
    }
    
}

extension NewPostViewController: saveImageDelegate {
    func saveNewImage(newImage: UIImage?) {
        image = selectedImage
    }
}

