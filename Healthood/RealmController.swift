//
//  RealmController.swift
//  Healthood
//
//  Created by Krystian Bujak on 03/10/2017.
//  Copyright © 2017 Krystian Bujak. All rights reserved.
//

import Foundation
import RealmSwift

final class RealmController: DateBaseFixture, DataBaseProtocol{
        
    var notificationToken: NotificationToken!
    var realm: Realm!
    let port = 9080
    var dataBaseType: DataBaseType = .realm
    var realmServerPath:String {
        return "http://\(serverPath):\(port)"   // "http://SERVER_IP"
    }
    var realmPath:String{
        return "realm://\(serverPath):\(port)/~/Healthood_0.4"  //"realm://SERVER_IP:9080/~/Healthood_*"
    }
    var dataBaseIP: String{
        return serverPath
    }
    
    override init(){
        super.init()
        SyncUser.logIn(with: .usernamePassword(username: self.dbUser, password: self.dbUserPassword, register: false), server: URL(string: self.realmServerPath)!){
            user, error in
            guard let user = user else { return }
            DispatchQueue.main.async {
                let configuration = Realm.Configuration(syncConfiguration: SyncConfiguration(user: user, realmURL: URL(string: self.realmPath)!))
                guard let realm = try? Realm(configuration: configuration) else { return }
                self.realm = realm
            }
        }        
    }
    
    public func registerUser(with userData: User) throws {
        if let realm = self.realm{
            guard realm.objects(RealmUser.self).filter("email == %@ or login == %@", userData.email, userData.login).count < 1 else { throw DateBaseErrors.credentialTaken }
            let realmUser = RealmUser(user: userData)
            try! realm.write {
                realm.add(realmUser)
            }
        }else{ throw DateBaseErrors.connectionError }
    }
    
    public func loginUser(with login: String, and password: String) throws -> User?{
        if let realm = self.realm{
            if let realmUser = realm.objects(RealmUser.self).filter("login == %@", login).first{
                if realmUser.password == String.SHA256("\(password)\(realmUser.salt)")!{
                    return User(realmUser: realmUser)
                }
            }
            return nil
        }else{ throw DateBaseErrors.connectionError }
    }
    
    public func getUser(with id: String) throws -> User? {
        if let realm = self.realm{
            if let realmUser = realm.objects(RealmUser.self).filter("id == %@", id).first{
                return User(realmUser: realmUser)
            }
            return nil
        }else{ throw DateBaseErrors.connectionError }
    }
    
    func changeUserProfileImage(with imageName: String, for userId: String) throws {
        if let realm = self.realm{
            if let realmUser = realm.objects(RealmUser.self).filter("id == %@", userId).first{
                try! realm.write {
                    realmUser.profileImagePath = "/realm/" + imageName
                }
            }else{ throw DateBaseErrors.invalidUserId }
        }else{ throw DateBaseErrors.connectionError }
    }
    
    func addFood(with food: Food) throws {
        if let realm = self.realm{
            if let realmUser = realm.objects(RealmUser.self).filter("id == %@", food.owner.id).first{
                let realmFood = RealmFood(food: food, for: realmUser)
                try! realm.write {
                    realm.add(realmFood)
                }
            }else{ throw DateBaseErrors.invalidUserId }
        }else{ throw DateBaseErrors.connectionError }
    }
}
