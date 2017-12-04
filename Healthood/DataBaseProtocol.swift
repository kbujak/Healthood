//
//  DataBaseProtocol.swift
//  Healthood
//
//  Created by Krystian Bujak on 03/10/2017.
//  Copyright © 2017 Krystian Bujak. All rights reserved.
//

import Foundation

protocol DataBaseProtocol{
    var dataBaseType: DataBaseType { set get }
    var dataBaseIP: String { get }
    
    func registerUser(with user: User) throws 
    func loginUser(with email: String, and password: String) throws -> User?
    func getUser(with id: String) throws -> User?
    func getFoods() throws -> [Food]
    func changeUserProfileImage(with imageName: String, for userId: String) throws
    func addFood(with food: Food) throws
    func addFoodImagePath(for foodID: String, with path: String) throws 
}
