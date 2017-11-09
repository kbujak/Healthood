//
//  RealmController.swift
//  Healthood
//
//  Created by Krystian Bujak on 03/10/2017.
//  Copyright © 2017 Krystian Bujak. All rights reserved.
//

import Foundation
import RealmSwift

final class RealmController: DataBaseProtocol{
    
    let dbUser = "kbujak421@gmail.com"
    let dbUserPassword = "test123"
    let serverPath = "http://34.240.47.19:9080"
    let realmPath = "realm://34.240.47.19:9080/~/Healthood_0.1"
    var notificationToken: NotificationToken!
    var realm: Realm!
    
    init(){
        SyncUser.logIn(with: .usernamePassword(username: self.dbUser, password: self.dbUserPassword, register: false), server: URL(string: self.serverPath)!){
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
//            if realm.objects(RealmUser.self).filter("email == %@ or login == %@", userData.email, userData.login).count > 0 { throw DateBaseErrors.credentialTaken }
            try! realm.write {
                let realmUser = RealmUser(user: userData)
                realm.add(realmUser)
            }
        }else{ throw DateBaseErrors.connectionError }
    }
    
    public func loginUser(with email: String, and password: String) throws -> User{
        if let realm = self.realm{
            if let realmUser = realm.objects(RealmUser.self).filter("email == %@", email).first{
                if realmUser.password == String.SHA256("\(password)\(realmUser.salt)")!{
                    return User(realmUser: realmUser)
                }else { throw DateBaseErrors.invalidPassword }
            }else{ throw DateBaseErrors.invalidEmail }
        }else{ throw DateBaseErrors.connectionError }
    }
    
}
