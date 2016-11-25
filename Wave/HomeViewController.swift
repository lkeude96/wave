//
//  HomeViewController.swift
//  Wave
//
//  Created by Eude Lesperance on 11/17/16.
//  Copyright © 2016 Eude Lesperance. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        
        navigationItem.title = "Home"
        
        collectionView?.backgroundColor = .white
        collectionView?.register(EventCell.self, forCellWithReuseIdentifier: "cellId")

//        let logoutBarButtonItem = UIBarButtonItem(barButtonSystemItem: .undo, target: nil, action: #selector(logout))
//        navItem.rightBarButtonItem = logoutBarButtonItem
//        navBar.setItems([navItem], animated: false)

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
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
