//
//  HomeViewController.swift
//  Wave
//
//  Created by Eude Lesperance on 11/17/16.
//  Copyright © 2016 Eude Lesperance. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    let navBar: UINavigationBar = {
        let navbar = UINavigationBar()
        navbar.translatesAutoresizingMaskIntoConstraints = false
        navbar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        navbar.tintColor = .white
        return navbar
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        navBar.barTintColor = UIColor(colorLiteralRed: 23/255, green: 42/255, blue: 58/255, alpha: 1.0)
        
        let navItem = UINavigationItem(title: (FIRAuth.auth()?.currentUser?.displayName) ?? "")
        let logoutBarButtonItem = UIBarButtonItem(barButtonSystemItem: .undo, target: nil, action: #selector(logout))
        navItem.rightBarButtonItem = logoutBarButtonItem
        navBar.setItems([navItem], animated: false)
        
        view.addSubview(navBar)
        
        navBar.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
        navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        navBar.heightAnchor.constraint(equalToConstant: 64).isActive = true
        
        // Do any additional setup after loading the view.
    }
    
    func logout() {
        try! FIRAuth.auth()?.signOut()
        present(LoginViewController(), animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
