//
//  DataBaseProtocol.swift
//  Healthood
//
//  Created by Krystian Bujak on 03/10/2017.
//  Copyright © 2017 Krystian Bujak. All rights reserved.
//

import Foundation

protocol DataBaseProtocol{
    func registerUser(with user: User)
    func loginUser(with email: String, and password: String)
}
