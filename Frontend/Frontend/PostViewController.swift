//
//  PostViewController.swift
//  Frontend
//
//  Created by Peter Huo on 12/14/20.
//

import UIKit

class PostViewController: UIViewController {
    
    var post: PostDataResponse!
    var userImageView = UIImageView(frame: CGRect(x:0, y:0, width:35, height:35))
    var userNameLabel = UILabel()
    var postImageView = UIImageView()
    var postNameLabel = UILabel()
    var postDescription = UITextView()
    var starImageView = UIImageView()
    
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
        userNameLabel.font = .boldSystemFont(ofSize: 18)
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
        
        setupConstraints()
        // Do any additional setup after loading the view.
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            userImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            userImageView.widthAnchor.constraint(equalToConstant:38),
            userImageView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            userImageView.heightAnchor.constraint(equalToConstant:38)
        ])
        
        NSLayoutConstraint.activate([
            userNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            userNameLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            userNameLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 77),
            userNameLabel.heightAnchor.constraint(equalToConstant:38)
        ])
        
        NSLayoutConstraint.activate([
            postImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 70),
            postImageView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            postImageView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            postImageView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor, constant: -175)
        ])
        
        NSLayoutConstraint.activate([
            postNameLabel.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 10),
            postNameLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -7),
            postNameLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor,constant: 7),
            postNameLabel.heightAnchor.constraint(equalToConstant: 17),
            postNameLabel.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor, constant: -147)
        ])
        
        NSLayoutConstraint.activate([
            postDescription.topAnchor.constraint(equalTo: postNameLabel.bottomAnchor),
            postDescription.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -3),
            postDescription.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor,constant: 3),
            postDescription.heightAnchor.constraint(equalToConstant: 100)
        ])

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
