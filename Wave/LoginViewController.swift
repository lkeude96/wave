//
//  ViewController.swift
//  Wave
//
//  Created by Eude Lesperance on 10/26/16.
//  Copyright © 2016 Eude Lesperance. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase

class LoginViewController: UIViewController {
    
    let logoLabel: UILabel = {
        let label = UILabel()
        label.text = "Wave"
        label.textColor = .white
        label.font = .systemFont(ofSize: 48, weight: UIFontWeightUltraLight)
        label.textAlignment = .center
        
        return label
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(colorLiteralRed: 23/255, green: 42/255, blue: 58/255, alpha: 1.0)
    
        view.addSubview(logoLabel)
        logoLabel.translatesAutoresizingMaskIntoConstraints = false
        
        logoLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 128).isActive = true
        logoLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        logoLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        
        let customLoginButton = UIButton(type: .system)
        // customLoginButton.backgroundColor = UIColor(colorLiteralRed: 59/255, green: 89/255, blue: 152/255, alpha: 1.0)
        customLoginButton.frame = CGRect(x: 16, y: self.view.frame.height / 2 + 96, width: self.view.frame.width - 32, height: 50)
        customLoginButton.layer.borderColor = UIColor.white.cgColor
        customLoginButton.layer.borderWidth = 1
        customLoginButton.layer.cornerRadius = customLoginButton.frame.height / 2
        customLoginButton.setTitle("Login With Facebook", for: .normal)
        customLoginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
        customLoginButton.setTitleColor(.white, for: .normal)
        view.addSubview(customLoginButton)
        
        customLoginButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
    }
    
    func handleLogin() {
        FBSDKLoginManager().logIn(withReadPermissions: ["email", "public_profile"], from: self) { (result, error) in
            if error != nil {
                print("Failed to start graph request: \(error)")
                return
            }
            
            self.showInfo()
        }
    }

    func showInfo() {
        guard let accessToken = FBSDKAccessToken.current().tokenString else { return }
        let credential = FIRFacebookAuthProvider.credential(withAccessToken: accessToken)
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil {
                print("Failed to sign in FB user: \(error)")
            }
            
            print("success: \(user)")
            
            self.present(FeedViewController(), animated: true, completion: nil)
        })
        
        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields": "id, name, email"]).start { (connection, result, error) in
            if error != nil {
                print("Failed to start graph request: \(error)")
                return
            }
            
            print("\(result)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

