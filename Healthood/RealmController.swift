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
        return "realm://\(serverPath):\(port)/~/Healthood_0.5"  //"realm://SERVER_IP:9080/~/Healthood_*"
    }
    var dataBaseIP: String{
        return serverPath
    }
    
    override init(){
        super.init()
        print(self.realmServerPath)
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
            guard realm.objects(RealmDeletedUsersEmail.self).filter("email == %@", userData.email).count < 1 else { throw DateBaseErrors.bannedUser }
            let realmUser = RealmUser(user: userData)
            try! realm.write {
                let start = DispatchTime.now()
                realm.add(realmUser)
                let end = DispatchTime.now()
                print(Double(end.uptimeNanoseconds - start.uptimeNanoseconds)/1000000000)
            }
        }else{ throw DateBaseErrors.connectionError }
    }
    
    public func loginUser(with login: String, and password: String) throws -> User?{
        if let realm = self.realm{
            if let realmUser = realm.objects(RealmUser.self).filter("login == %@", login).first{
                if realmUser.password == String.SHA256("\(password)\(realmUser.salt)")!{
                    if let realmBanContainer = realm.objects(RealmBanContainer.self).filter("userId == %@", realmUser.id).first{
                        if realmBanContainer.level == 1{
                            if Date() < realmBanContainer.punishementDate!{
                                throw FoodListErrors.bannedUser
                            }
                        }
                    }
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
                    realmUser.profileImagePath = "/realm/profile/" + imageName
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
    
    func getFoods() throws -> [Food]? {
        if let realm = self.realm{
            let realmFoods = realm.objects(RealmFood.self)
            if realmFoods.count > 0{
                var foods = [Food]()
                for realmFood in realmFoods{
                    if let user = try getUser(with: realmFood.owner!.id){
                        foods.append(Food(realmFood: realmFood, owner: user))
                    }
                }
                return foods
            }
            return nil
        }else{ throw DateBaseErrors.connectionError }
    }
    
    func createFoods(for count: Int) throws {
        throw RegisterErrors.emailError
    }
    
    func banUser(with userId: String) throws {
        if let realm = self.realm{
            if let realmBanContainer = realm.objects(RealmBanContainer.self).filter("userId == %@", userId).first{
                if realmBanContainer.level == 0{
                    try! realm.write {
                        realmBanContainer.level += 1
                        realmBanContainer.punishementDate = Date(timeIntervalSinceNow: 60)
                    }
                }else if realmBanContainer.level == 1{
                    if let realmUser = realm.objects(RealmUser.self).filter("id == %@", userId).first{
                        try! realm.write {
                            realm.add(RealmDeletedUsersEmail(email: realmUser.email))
                            realm.delete(realmUser)
                            realm.delete(realmBanContainer)
                        }
                    }
                }
                
            }else if realm.objects(RealmUser.self).filter("id == %@", userId).count > 0{
                try! realm.write {
                    realm.add(RealmBanContainer(userId: userId))
                }
            }else{ throw DateBaseErrors.invalidUserId }
            
        }else{ throw DateBaseErrors.connectionError }
    }
}
