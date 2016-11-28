//
//  HomeViewController.swift
//  Wave
//
//  Created by Eude Lesperance on 11/17/16.
//  Copyright © 2016 Eude Lesperance. All rights reserved.
//

import UIKit
import Firebase
import KCFloatingActionButton

class HomeViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, KCFloatingActionButtonDelegate {
    static let shared: HomeViewController = HomeViewController(collectionViewLayout: UICollectionViewFlowLayout())
    var events: [Event] = {
        let brhouseparty = Event()
        brhouseparty.thumbnailImageName = "event"
        brhouseparty.eventName = "BR House Party"
        brhouseparty.eventCost = 16.5
        brhouseparty.eventDate = "TBD"
        
        let freefoodevent = Event()
        freefoodevent.thumbnailImageName = "food"
        freefoodevent.eventName = "Free Food Event"
        freefoodevent.eventCost = 0.0
        freefoodevent.eventDate = "TBD"
        
        let whitepeopleparty = Event()
        whitepeopleparty.thumbnailImageName = "dinner"
        whitepeopleparty.eventName = "Fancy Dinner"
        whitepeopleparty.eventCost = 5000.0
        whitepeopleparty.eventDate = "TBD"
        
        return [brhouseparty, freefoodevent, whitepeopleparty, brhouseparty, freefoodevent, whitepeopleparty]
    }()
    
    let menuBar: MenuBar = {
        let menuBar = MenuBar()
        menuBar.translatesAutoresizingMaskIntoConstraints = false
        return menuBar
    }()
    
    let addEventFAB: KCFloatingActionButton = {
        let fab = KCFloatingActionButton()
        return fab
    }()
    
    var horizontalBarLeftAnchorConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
       
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        navigationController?.navigationBar.tintColor = .white
        
        let titleLabel = UILabel(frame: CGRect(x: 0,y: 0,width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "Home"
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
        
        collectionView?.backgroundColor = .white
        collectionView?.register(EventCell.self, forCellWithReuseIdentifier: "cellId")
        
        collectionView?.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        
        collectionView?.isPagingEnabled = true
        
        KCFABManager.defaultInstance().getButton().fabDelegate = self
        
        setupNavBarButtons()
        setupMenuBar()
        
        guard (FIRAuth.auth()?.currentUser) != nil else {
            present(LoginViewController(), animated: true, completion: nil)
            return
        }
        
//        let alertController: UIAlertController = UIAlertController(title: "Hi", message: "Welcome \(displayName)", preferredStyle: .alert)
//        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//        self.present(alertController, animated: true, completion: nil)
        
        
        
    }
    
    func KCFABOpened(_ fab: KCFloatingActionButton) {
        print("FAB Opened")
    }
    
    func KCFABClosed(_ fab: KCFloatingActionButton) {
        print("FAB Closed")
    }
    
    private func setupNavBarButtons() {
        let searchBarButtonItem = UIBarButtonItem(image: UIImage(named: "search")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleSearch))
        let moreBarButtonItem = UIBarButtonItem(image: UIImage(named: "more")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMore))
        
        
        navigationItem.rightBarButtonItems = [moreBarButtonItem, searchBarButtonItem]
        
    }
    
    private func setupMenuBar() {
        view.addSubview(menuBar)
        
        menuBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        menuBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        menuBar.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        menuBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func logout() {
        try! FIRAuth.auth()?.signOut()
        
        present(LoginViewController(), animated: true, completion: nil)
    }
    
    func handleSearch() {
        
    }
    
    func handleMore() {
        let alertController = UIAlertController(title: "More", message: nil, preferredStyle: .actionSheet)
        let logoutAction: UIAlertAction = UIAlertAction(title: "Logout", style: .destructive) { action in
            self.logout()
        }
        let createEventAction: UIAlertAction = UIAlertAction(title: "Create an event", style: .default) { action in
            self.navigationController?.pushViewController(CreateEventViewController(), animated: true)
        }
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        
        alertController.addAction(cancelAction)
        alertController.addAction(createEventAction)
        alertController.addAction(logoutAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return events.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! EventCell
        
        cell.event = events[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
