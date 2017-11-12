//
//  RealmUser.swift
//  Healthood
//
//  Created by Krystian Bujak on 03/10/2017.
//  Copyright © 2017 Krystian Bujak. All rights reserved.
//

import Foundation
import RealmSwift

class RealmUser: Object{
    dynamic var id: String = ""
    dynamic var name: String = ""
    dynamic var surName: String = ""
    dynamic var login: String = ""
    dynamic var email: String = ""
    dynamic var password: String = ""
    dynamic var salt: String = ""
    dynamic var profileImagePath: String?
    
    convenience init(user: User){
        self.init()
        self.id = user.id
        self.name = user.name
        self.surName = user.surName
        self.login = user.login
        self.email = user.email
        self.salt = String.randomString(length: 20)
        self.password = String.SHA256("\(user.password)\(salt)")!
        self.profileImagePath = user.profileImagePath
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
