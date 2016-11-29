//
//  User.swift
//  Wave
//
//  Created by Eude Lesperance on 11/28/16.
//  Copyright © 2016 Eude Lesperance. All rights reserved.
//

import Foundation
import Firebase

struct User {
    let uid: String
    let fullName: String
    let email: String
    
    init(userData: FIRUser) {
        self.uid = userData.uid
        self.fullName = userData.displayName ?? ""
        self.email = userData.email ?? ""
        
    }
    
    init(uid: String, fullName: String, email: String) {
        self.uid = uid
        self.fullName = fullName
        self.email = email
    }
}
