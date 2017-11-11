//
//  DataBaseProtocol.swift
//  Healthood
//
//  Created by Krystian Bujak on 03/10/2017.
//  Copyright © 2017 Krystian Bujak. All rights reserved.
//

import Foundation

protocol DataBaseProtocol{
    func registerUser(with user: User) throws 
    func loginUser(with email: String, and password: String) throws -> User?
    func getUser(with id: String) throws -> User?
    func changeUserProfileImage(with image: Data, for userId: String) throws
}
