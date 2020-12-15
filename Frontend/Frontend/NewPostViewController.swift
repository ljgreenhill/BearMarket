////
////  NewPostViewController.swift
////  Frontend
////
////  Created by Edward on 12/13/20.
////
import UIKit
import Lottie

var postTitle : UITextField!
var descript : UITextField!
var price : UITextField!
var titleLabel: UILabel!
var descriptLabel: UILabel!
var priceLabel: UILabel!
var postButton: UIBarButtonItem!
//var imageButton: UIButton!
//var imageView: UIImageView!
//var image: UIImage?
//var imagePicker: ContentView!

class NewPostViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "New Post"
        navigationController?.navigationBar.barTintColor = UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1)
        view.backgroundColor = .white
        
        postTitle = UITextField()
        postTitle.placeholder = "Item Name"
        postTitle.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(postTitle)
        
        descript = UITextField()
        descript.placeholder = "Item Description"
        descript.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(descript)
        
        price = UITextField()
        price.placeholder = "$"
        price.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(price)
        
        titleLabel = UILabel()
        titleLabel.text = "Post Title:"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        descriptLabel = UILabel()
        descriptLabel.text = "Description:"
        descriptLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(descriptLabel)
        
        priceLabel = UILabel()
        priceLabel.text = "Price:"
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(priceLabel)
        
        postButton = UIBarButtonItem(title: "Post", style: .plain, target: self, action: #selector(popAndSaveNewPost))
        navigationItem.rightBarButtonItem = postButton
        
        //imagePicker = ContentView()
        //view.addSubview(imagePicker)
        
        /*
        imageButton = UIButton()
        imageButton.setTitle("Select Image", for: .normal)
        imageButton.setTitleColor(.red, for: .normal)
        imageButton.addTarget(self, action: #selector(pushImagePicker), for: .touchUpInside)
        imageButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageButton)

        image = UIImage()
        
        imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        */
        

        
    }
 
    private func setUpConstraints(){
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            titleLabel.widthAnchor.constraint(equalToConstant: 100),
            titleLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            priceLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            priceLabel.widthAnchor.constraint(equalToConstant: 100),
            priceLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        NSLayoutConstraint.activate([
            descriptLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 30),
            descriptLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            descriptLabel.widthAnchor.constraint(equalToConstant: 100),
            descriptLabel.heightAnchor.constraint(equalToConstant: 30)
        ])

        
        NSLayoutConstraint.activate([
            postTitle.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 30),
            postTitle.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 15),
            postTitle.widthAnchor.constraint(equalToConstant: 100),
            postTitle.heightAnchor.constraint(equalToConstant: 30)
        ])
        NSLayoutConstraint.activate([
            price.topAnchor.constraint(equalTo: priceLabel.topAnchor, constant: 30),
            price.leadingAnchor.constraint(equalTo: priceLabel.trailingAnchor, constant: 15),
            price.widthAnchor.constraint(equalToConstant: 100),
            price.heightAnchor.constraint(equalToConstant: 30)
        ])
        NSLayoutConstraint.activate([
            descript.topAnchor.constraint(equalTo: descriptLabel.topAnchor, constant: 30),
            descript.leadingAnchor.constraint(equalTo: descriptLabel.trailingAnchor, constant: 15),
            descript.widthAnchor.constraint(equalToConstant: 100),
            descript.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    @objc func popAndSaveNewPost() {
        
        
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
        
    }
    
    /*@objc func pushImagePicker() {
        let vc = ImagePickerViewController(delegate: self, titleString: imageButton.titleLabel?.text)
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc func createNewPost() {
        
    }
    
}

extension NewPostViewController: saveImageDelegate {
    func saveNewImage(newImage: UIImage) {
        image = selectedImage
    }*/
}

extension NewPostViewController {
    private func createPost(_ button: UIBarButtonItem) {
        if let title = postTitle.text, let descript = descript.text, let price = price.text {
            NetworkManager.newPost(title: title, description: descript, price: price, image: "data:image/gif;base64,R0lGODlhAQABAAAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==")  { _ in
                var animationView: AnimationView?

                animationView = .init(name: "check-animation")
                  
                animationView!.frame = self.view.bounds
                  
                  
                animationView!.contentMode = .scaleAspectFit
                  
                animationView!.loopMode = .playOnce
                  
                animationView!.animationSpeed = 0.8
                  
                self.view.addSubview(animationView!)
                  
                animationView!.play()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                    self.dismiss(animated: true, completion: nil)
                })
        }
    }
}
}
