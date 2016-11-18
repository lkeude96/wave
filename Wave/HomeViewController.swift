//
//  HomeViewController.swift
//  Wave
//
//  Created by Eude Lesperance on 11/17/16.
//  Copyright © 2016 Eude Lesperance. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UICollectionViewController {

//    let navBar: UINavigationBar = {
//        let navbar = UINavigationBar()
//        navbar.translatesAutoresizingMaskIntoConstraints = false
//        navbar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
//        navbar.tintColor = .white
//        return navbar
//    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        collectionView?.backgroundColor = .white
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellId")
        
//        navBar.barTintColor = UIColor(colorLiteralRed: 23/255, green: 42/255, blue: 58/255, alpha: 1.0)
        
        navigationItem.title = "Home"
        
//        let navItem = UINavigationItem(title: "Home")//(FIRAuth.auth()?.currentUser?.displayName) ?? "")
//        let logoutBarButtonItem = UIBarButtonItem(barButtonSystemItem: .undo, target: nil, action: #selector(logout))
//        navItem.rightBarButtonItem = logoutBarButtonItem
//        navBar.setItems([navItem], animated: false)
//        
//        view.addSubview(navBar)
//        
//        navBar.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
//        navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//        navBar.heightAnchor.constraint(equalToConstant: 64).isActive = true
//        
//        collectionView?.topAnchor.constraint(equalTo: navBar.bottomAnchor).isActive = true
//        collectionView?.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        collectionView?.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//        collectionView?.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func logout() {
        try! FIRAuth.auth()?.signOut()
        present(LoginViewController(), animated: true, completion: nil)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath)
        
        cell.backgroundColor = .red
        return cell
    }
}
