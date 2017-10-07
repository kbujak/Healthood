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
    let serverPath = "http://34.240.27.1:9080"
    let realmPath = "realm://34.240.27.1:9080/~/Healthood"
    var notificationToken: NotificationToken!
    var realm: Realm!
    
    private func connectToRealm(with user: SyncUser){
            let configuration = Realm.Configuration(syncConfiguration: SyncConfiguration(user: user, realmURL: URL(string: self.realmPath)!))
            self.realm = try! Realm(configuration: configuration)
    }
    
    public func registerUser(with userData: User) {
        SyncUser.logIn(with: .usernamePassword(username: self.dbUser, password: self.dbUserPassword, register: false), server: URL(string: serverPath)!){
            user, error in
            guard let user = user else { fatalError(String(describing: error))}
            DispatchQueue.main.async {
                self.connectToRealm(with: user)
                if let realm = self.realm{
                    try! realm.write {
                        realm.add(RealmUser(user: userData))
                    }
                }
            }
        }
        print("Zarejestrowany")
    }
    
    public func loginUser(with email: String, and password: String){
        SyncUser.logIn(with: .usernamePassword(username: email, password: password, register: false), server: URL(string: serverPath)!){
            user, error in
            guard let user = user else { fatalError(String(describing: error)) }
            self.connectToRealm(with: user)
        }
    }
    
}
