//
//  RealmDeletedUsersEmail.swift
//  Healthood
//
//  Created by Krystian Bujak on 24/11/2017.
//  Copyright © 2017 Krystian Bujak. All rights reserved.
//

import Foundation
import RealmSwift

class RealmDeletedUsersEmail: Object{
    dynamic var email: String = ""
    dynamic var date: Date!
    
    convenience init(email: String) {
        self.init()
        self.email = email
        self.date = Date()
    }
}
