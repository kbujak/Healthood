//
//  RegisterErrors.swift
//  Healthood
//
//  Created by Krystian Bujak on 10/10/2017.
//  Copyright © 2017 Krystian Bujak. All rights reserved.
//

import Foundation

enum RegisterErrors: String, Error{
    case nameError = "Invalid name"
    case surnameError = "Invalid surname"
    case loginError = "Invalid login"
    case loginTakenError = "Login is already taken"
    case passwordError = "Invalid password"
    case emailError = "Invalid email"
    case vulgarismError = "Your data contain vulgar word"
}
