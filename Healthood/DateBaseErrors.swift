//
//  RealmErrors.swift
//  Healthood
//
//  Created by Krystian Bujak on 07/11/2017.
//  Copyright © 2017 Krystian Bujak. All rights reserved.
//

import Foundation

enum DateBaseErrors: String, Error{
    case connectionError = "There is problem with connection"
    case invalidEmail = "Invalid email"
    case invalidPassword = "Invalid password"
    case credentialTaken = "Given credentials are taken"
    case invalidUserId = "User with given id doesn't exist"
}
