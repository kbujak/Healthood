//
//  SQliteUser.swift
//  Healthood
//
//  Created by Krystian Bujak on 09/12/2017.
//  Copyright © 2017 Krystian Bujak. All rights reserved.
//

import Foundation
import SQLite

class SQliteUserTable{
    let users = Table("user")
    let id = Expression<String>("id")
    let name = Expression<String>("name")
    let surname = Expression<String>("surname")
    let login = Expression<String>("login")
    let email = Expression<String>("email")
    let password = Expression<String>("password")
    let salt = Expression<String>("salt")
    let profileImagePath = Expression<String?>("profileImagePath")
}
