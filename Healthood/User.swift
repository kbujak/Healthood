//
//  User.swift
//  Healthood
//
//  Created by Krystian Bujak on 03/10/2017.
//  Copyright © 2017 Krystian Bujak. All rights reserved.
//

import Foundation

class User{
    var id: String
    var name: String
    var surName: String
    var login: String
    var email: String
    var password: String
    var profileImage: Data?
    
    init(name: String, surName: String, login: String, email: String, password: String, profileImage: Data? = nil) {
        self.id = UUID().uuidString
        self.name = name
        self.surName = surName
        self.login = login
        self.email = email
        self.password = password
        self.profileImage = profileImage
    }
    
    init(realmUser: RealmUser){
        self.id = realmUser.id
        self.name = realmUser.name
        self.surName = realmUser.surName
        self.login = realmUser.login
        self.email = realmUser.email
        self.password = realmUser.password
    }
}
