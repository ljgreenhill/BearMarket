//
//  ViewController.swift
//  HackChallenge
//
//  Created by Peter Huo on 11/25/20.
//

import UIKit
import GoogleSignIn
import SafariServices

class ViewController: UIViewController, SFSafariViewControllerDelegate{
    
    let toolBarController = UITabBarController()
    let profileView = UINavigationController(rootViewController: MePageViewController())
    let mainView = UINavigationController(rootViewController: HomePageViewController())
    let postingView = UINavigationController(rootViewController: NewPostViewController())
    let signInButton = UIButton()
    let backgroundView = UIImageView()
    //let signInButton = GIDSignInButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = "https://bear-market.herokuapp.com"

        if let url = URL(string: urlString) {
            let vc = SFSafariViewController(url: url, entersReaderIfAvailable: true)
            vc.delegate = self

            present(vc, animated: true)
        }

        title = "Login"
        view.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
        
        backgroundView.image = UIImage(named: "background")
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.clipsToBounds = true
        backgroundView.layer.masksToBounds = true
        backgroundView.contentMode = .scaleAspectFill
        view.addSubview(backgroundView)
        
        signInButton.setTitle("Sign In",for: .normal)
        signInButton.backgroundColor = .white
        signInButton.setTitleColor(.black, for: .normal)
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        view.addSubview(signInButton)

        setupConstraints()
//
//        GIDSignIn.sharedInstance()?.presentingViewController = self
//
//        // Automatically sign in the user.
//        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
////
//          // ...
//
//        signInButton.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(signInButton)
//
//        setupConstraints()

//        navigationController?.navigationBar.barTintColor = UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1)
//        view.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
//
//        toolBarController.setViewControllers([mainView, profileView], animated: false)
//
//        toolBarController.modalPresentationStyle = .fullScreen
//        present(toolBarController,animated:true)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            ])
        
        NSLayoutConstraint.activate([
            signInButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            signInButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: 40),
            signInButton.widthAnchor.constraint(equalToConstant: 200),
            signInButton.heightAnchor.constraint(equalToConstant: 52)
        ])
//        NSLayoutConstraint.activate([
//            signInButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
//            signInButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
//        ])
    }

    @objc func didTapButton() {
        let tabBarVC = UITabBarController()
        tabBarVC.setViewControllers([mainView,profileView,postingView], animated: false)

        mainView.title = "Home"
        profileView.title = "Profile"
        postingView.title = "Posting"

        guard let items = tabBarVC.tabBar.items else {
            return
        }

        let images = ["house","person","camera"]
        for x in 0..<items.count {
            items[x].image = UIImage(systemName: images[x])
        }

        tabBarVC.modalPresentationStyle = .fullScreen
        present(tabBarVC, animated: true)
        
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        dismiss(animated: true)
    }
    
}
