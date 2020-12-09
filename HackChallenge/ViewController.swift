//
//  ViewController.swift
//  HackChallenge
//
//  Created by Peter Huo on 11/25/20.
//

import UIKit

class ViewController: UIViewController {
    
    let toolBarController = UITabBarController()
    let profileView = MePageViewController()
    let mainView = MainViewViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1)
        view.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
        
        toolBarController.setViewControllers([mainView, profileView], animated: false)
        
        toolBarController.modalPresentationStyle = .fullScreen
        present(toolBarController,animated:true)
    }
}
