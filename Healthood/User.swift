//
//  User.swift
//  Healthood
//
//  Created by Krystian Bujak on 03/10/2017.
//  Copyright © 2017 Krystian Bujak. All rights reserved.
//

import Foundation

class User{
    var name: String
    var surName: String
    var login: String
    var email: String
    var password: String
    var birthday: Date
    
    init(name: String, surName: String, login: String, email: String, password: String, birthday: Date){
        self.name = name
        self.surName = surName
        self.login = login
        self.email = email
        self.password = password
        self.birthday = birthday
    }
}
