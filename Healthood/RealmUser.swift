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
    dynamic var name: String = ""
    dynamic var surName: String = ""
    dynamic var login: String = ""
    dynamic var email: String = ""
    dynamic var password: String = ""
    dynamic var birthday: Date = Date()
    
    convenience init(user: User){
        self.init()
        self.name = user.name
        self.surName = user.surName
        self.login = user.login
        self.email = user.email
        self.password = user.password
        self.birthday = user.birthday
    }
}
