//
//  ViewController.swift
//  HackChallenge
//
//  Created by Peter Huo on 11/25/20.
//

import UIKit
import GoogleSignIn

class ViewController: UIViewController {
    
    let toolBarController = UITabBarController()
    let profileView = MePageViewController()
    let mainView = MainViewViewController()
    let signInButton = GIDSignInButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance()?.presentingViewController = self

          // Automatically sign in the user.
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()

          // ...
        
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(signInButton)
        
        setupConstraints()

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
            signInButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            signInButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
    }
}
