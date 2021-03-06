//
//  PostViewController.swift
//  Frontend
//
//  Created by Peter Huo on 12/14/20.
//

import UIKit
import Lottie

class PostViewController: UIViewController {
    
    var post: PostDataResponse!
    var userImageView = UIImageView(frame: CGRect(x:0, y:0, width:35, height:35))
    var userNameLabel = UILabel()
    var postImageView = UIImageView()
    var postNameLabel = UILabel()
    var postDescription = UITextView()
    var favoriteButton = UIButton()
    var priceLabel = UILabel()
    var emailLabel = UILabel()
    
    init(post:PostDataResponse) {
        super.init(nibName: nil, bundle: nil)
        self.post = post
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1)
        view.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
        title = "Post"
        
        
        NetworkManager.getUserByID(id: post.seller) { user in
            self.userNameLabel.text = user.name
            let userPicURL = URL(string: user.profile_pic)
            self.userImageView.kf.setImage(with: userPicURL)
            self.emailLabel.text = "(" + user.email + ")"
        }
        
        //userImageView.image = UIImage(named: "user2")
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        userImageView.clipsToBounds = true
        userImageView.layer.masksToBounds = true
        userImageView.layer.borderWidth = 1.0
        userImageView.layer.cornerRadius = userImageView.frame.size.width/2
        view.addSubview(userImageView)
        
        //userNameLabel.text = "User"
        userNameLabel.textColor = .black
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.font = .boldSystemFont(ofSize: 15)
        view.addSubview(userNameLabel)
        
        let photoURL = URL(string: post.image)
        postImageView.kf.setImage(with: photoURL)
        postImageView.translatesAutoresizingMaskIntoConstraints = false
        postImageView.clipsToBounds = true
        postImageView.layer.masksToBounds = true
        postImageView.contentMode = .scaleAspectFill
        view.addSubview(postImageView)

        //postNameLabel.text = "A Lamp!"
        postNameLabel.text = post.title
        postNameLabel.textColor = .black
        postNameLabel.translatesAutoresizingMaskIntoConstraints = false
        postNameLabel.font = .boldSystemFont(ofSize: 15)
        view.addSubview(postNameLabel)
        
        //postDescription.text = "Hello everyone! Hope your hack challenge projects are coming along nicely. We would love for everyone to join us in celebrating the amazing mobile apps that you all have created over the past two weeks! The finale is on Tuesday at 9 pm ET. As a reminder, your final submissions are due on Monday at 11:59 pm ET."
        postDescription.text = post.description
        postDescription.translatesAutoresizingMaskIntoConstraints = false
        postDescription.isEditable = false
        postDescription.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
        postDescription.textColor = .black
        postDescription.font = .systemFont(ofSize: 11)
        view.addSubview(postDescription)
        
        favoriteButton.setTitle("Favorite",for: .normal)
        favoriteButton.backgroundColor = .gray
        favoriteButton.setTitleColor(.black, for: .normal)
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.titleLabel?.font = .boldSystemFont(ofSize: 12)
        favoriteButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        view.addSubview(favoriteButton)
        
        priceLabel.text = post.price
        priceLabel.backgroundColor = .gray
        priceLabel.textColor = .white
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.font = .boldSystemFont(ofSize: 15)
        priceLabel.textAlignment = .center
        view.addSubview(priceLabel)
        
        emailLabel.textColor = .black
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.font = .systemFont(ofSize: 12)
        view.addSubview(emailLabel)
        
        setupConstraints()
        // Do any additional setup after loading the view.
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            userImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 9),
            userImageView.widthAnchor.constraint(equalToConstant:35),
            userImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 13),
            userImageView.heightAnchor.constraint(equalToConstant:35)
        ])
        
        NSLayoutConstraint.activate([
            userNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 9),
            userNameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            userNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 60),
            userNameLabel.heightAnchor.constraint(equalToConstant:35)
        ])
        
        NSLayoutConstraint.activate([
            postImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 51),
            postImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            postImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            postImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -120)
        ])
        
        NSLayoutConstraint.activate([
            postNameLabel.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 10),
            postNameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -7),
            postNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 7),
            postNameLabel.heightAnchor.constraint(equalToConstant: 17),
            postNameLabel.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor, constant: -95)
        ])
        
        NSLayoutConstraint.activate([
            postDescription.topAnchor.constraint(equalTo: postNameLabel.bottomAnchor),
            postDescription.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -3),
            postDescription.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 3),
            postDescription.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            favoriteButton.topAnchor.constraint(equalTo: postNameLabel.topAnchor, constant: -6),
            favoriteButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -3),
            favoriteButton.widthAnchor.constraint(equalToConstant: 60),
            //starImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 280),
            favoriteButton.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: -25),
            priceLabel.trailingAnchor.constraint(equalTo: postImageView.trailingAnchor),
            priceLabel.bottomAnchor.constraint(equalTo: postImageView.bottomAnchor),
            priceLabel.leadingAnchor.constraint(equalTo: postImageView.leadingAnchor, constant:250)
        ])
        
        NSLayoutConstraint.activate([
            emailLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 11.5),
            emailLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            emailLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 180),
            emailLabel.heightAnchor.constraint(equalToConstant:30)
        ])
    }
    
    @objc func didTapButton() {
        if favoriteButton.titleLabel?.text == "Favorite" {
            favoriteButton.setTitle("Favorite!", for: .normal)
            favoriteButton.backgroundColor = .yellow
            
            NetworkManager.interested(itemId: post.id) {_ in
                var animationView: AnimationView?
                animationView = .init(name: "favorite")
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
//        else {
//            favoriteButton.setTitle("Favorite", for: .normal)
//            favoriteButton.backgroundColor = .gray
//        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
