//
//  SQliteController.swift
//  Healthood
//
//  Created by Krystian Bujak on 09/12/2017.
//  Copyright © 2017 Krystian Bujak. All rights reserved.
//

import Foundation
import SQLite

class SQliteController: DataBaseProtocol{
    let userTable = SQliteUserTable()
    let ingridientTable = SQliteIngridientTable()
    let rateTable = SQliteRateTable()
    let foodTable = SQliteFoodTable()
    let recipeTable = SQliteRecipeTable()
    
    var dataBase: Connection!
    var dataBaseType: DataBaseType = .sqlite    

    var sqlitePath: String{
        return "/Users/Booyac/Developer/Healthood/sqlite/healthood_sql.db"  //"realm://SERVER_IP:9080/~/Healthood_*"
    }
    
    init(){
        do{
            self.dataBase = try Connection(sqlitePath)
        }catch{
            print(error)
        }
    }
    
    func registerUser(with user: User) throws {
        if let dataBase = self.dataBase{
            
            if try dataBase.prepare(userTable.users).first(where: { ($0[userTable.login] == user.login) || ($0[userTable.email] == user.email)}) != nil{
                throw DateBaseErrors.credentialTaken
            }
            
            let salt = String.randomString(length: 20)
            let insert = userTable.users.insert(
                userTable.id <- user.id,
                userTable.name <- user.name,
                userTable.surname <- user.surName,
                userTable.login <- user.login,
                userTable.email <- user.email,
                userTable.password <- String.SHA256("\(user.password)\(salt)")!,
                userTable.salt <- salt,
                userTable.profileImagePath <- user.profileImagePath)
            
            try dataBase.run(insert)
        }else{ throw DateBaseErrors.connectionError }
    }
    
    func loginUser(with login: String, and password: String) throws -> User? {
        if let dataBase = self.dataBase{
            if let row = try dataBase.prepare(userTable.users).first(where: { $0[userTable.login] == login }){
                if row[userTable.password] == String.SHA256("\(password)\(row[userTable.salt])"){
                    return User(id: row[userTable.id], name: row[userTable.name], surName: row[userTable.surname], login: row[userTable.login], email: row[userTable.email], password: row[userTable.password], profileImagePath: row[userTable.profileImagePath])
                }
            }
            return nil
        }else{ throw DateBaseErrors.connectionError }
    }
    
    func getUser(with id: String) throws -> User? {
        if let dataBase = self.dataBase{
            if let row = try dataBase.prepare(userTable.users).first(where: { $0[userTable.id] == id }){
                return User(id: row[userTable.id], name: row[userTable.name], surName: row[userTable.surname], login: row[userTable.login], email: row[userTable.email], password: row[userTable.password], profileImagePath: row[userTable.profileImagePath])
            }
            return nil
        }else{ throw DateBaseErrors.connectionError }
    }
    
    func getFoods() throws -> [Food] {
        if let dataBase = self.dataBase{
            var foodArray = [Food]()
            for foodRow in try dataBase.prepare(foodTable.foods){
                var ingridients = [Ingridient]()
                var rate: Rate
                for recipeRow in try dataBase.prepare(recipeTable.recipes).filter({ $0[recipeTable.food_id] == foodRow[foodTable.id]}){
                    if let ingridientRow = try dataBase.prepare(ingridientTable.ingridients).first{$0[ingridientTable.id] == recipeRow[recipeTable.id_ingridient]}{
                        ingridients.append(Ingridient(name: ingridientRow[ingridientTable.name], count: ingridientRow[ingridientTable.count], unit: ingridientRow[ingridientTable.unit]))
                    }
                }
                
                if let rateRow = try dataBase.prepare(rateTable.rates).first(where: {$0[rateTable.id] == foodRow[foodTable.id_rate]}){
                    rate = Rate(sum: rateRow[rateTable.sum], count: rateRow[rateTable.count])
                }
                
                foodArray.append(Food(
                    owner: try getUser(with: foodRow[foodTable.id_user])!,
                    ingridients: ingridients,
                    title: foodRow[foodTable.title],
                    description: foodRow[foodTable.description],
                    durationTime: foodRow[foodTable.duration_time],
                    calories: foodRow[foodTable.calories],
                    protein: foodRow[foodTable.protein],
                    fat: foodRow[foodTable.fat],
                    carbohydrates: foodRow[foodTable.carbohydrates],
                    sugar: foodRow[foodTable.sugar],
                    imagePath: foodRow[foodTable.imagepath])
                )
            }
            
            return foodArray
        }else{ throw DateBaseErrors.connectionError }
    }
    
    func changeUserProfileImage(with imageName: String, for userId: String) throws {
        if let dataBase = self.dataBase{
            if try dataBase.prepare(userTable.users).first(where: { $0[userTable.id] == userId }) != nil{
                let user = userTable.users.filter(userTable.id == userId)
                try dataBase.run(user.update(userTable.profileImagePath <- imageName))
            }else{ throw DateBaseErrors.invalidUserId }
        }else{ throw DateBaseErrors.connectionError }
    }
    
    func addFood(with food: Food) throws {
        if let dataBase = self.dataBase{
            if let row = try dataBase.prepare(userTable.users).first(where: { $0[userTable.id] == food.owner.id }){
                let rateInsert = rateTable.rates.insert(
                    rateTable.sum <- food.rating.sum,
                    rateTable.count <- food.rating.count
                )
                let rateId = try dataBase.run(rateInsert)
                
                let foodInsert = foodTable.foods.insert(
                    foodTable.id <- food.id,
                    foodTable.id_user <- row[userTable.id],
                    foodTable.imagepath <- food.imagePath ?? "",
                    foodTable.date <- food.data,
                    foodTable.title <- food.title,
                    foodTable.description <- food.description,
                    foodTable.id_rate <- Int(rateId),
                    foodTable.duration_time <- food.durationTime,
                    foodTable.calories <- food.calories,
                    foodTable.protein <- food.protein,
                    foodTable.fat <- food.fat,
                    foodTable.carbohydrates <- food.carbohydrates,
                    foodTable.sugar <- food.sugar
                )
                try dataBase.run(foodInsert)
                
                for ingridient in food.ingridients{
                    let ingridientInsert = ingridientTable.ingridients.insert(
                        ingridientTable.name <- ingridient.name,
                        ingridientTable.count <- ingridient.count,
                        ingridientTable.unit <- ingridient.unit
                    )
                    let ingridientId = try dataBase.run(ingridientInsert)
                    
                    let recipeInsert = recipeTable.recipes.insert(
                        recipeTable.food_id <- food.id,
                        recipeTable.id_ingridient <- Int(ingridientId)
                    )
                    try dataBase.run(recipeInsert)
                }
            }else{
                print(food.owner.id)
                throw DateBaseErrors.invalidUserId }
        }else{ throw DateBaseErrors.connectionError }
    }
    
    func addFoodImagePath(for foodID: String, with path: String) throws {
        if let dataBase = self.dataBase{
            if try dataBase.prepare(foodTable.foods).first(where: { $0[foodTable.id] == foodID }) != nil{
                let food = foodTable.foods.filter(foodTable.id == foodID)
                try dataBase.run(food.update(foodTable.imagepath <- path))
            }
        }else{ throw DateBaseErrors.connectionError }
    }
    
    func test(with ingridientArray: [Ingridient]) throws -> [String : Double] {
        if let dataBase = self.dataBase{
            var insertArray = [Insert]()
            for ingridient in ingridientArray{
                insertArray.append(ingridientTable.ingridients.insert(
                    ingridientTable.name <- ingridient.name,
                    ingridientTable.count <- ingridient.count,
                    ingridientTable.unit <- ingridient.unit)
                )
            }
            
            let addingStart = DispatchTime.now()
            for insert in insertArray{
                try dataBase.run(insert)
            }
            let addingEnd = DispatchTime.now()
            
            let selectingStart = DispatchTime.now()
            try dataBase.prepare(ingridientTable.ingridients)
            let selectingEnd = DispatchTime.now()
            
            let modifingStart = DispatchTime.now()
            try dataBase.run(ingridientTable.ingridients.update(ingridientTable.name <- "name"))
            let modifingEnd = DispatchTime.now()

            return [
                "insert": Double(addingEnd.uptimeNanoseconds - addingStart.uptimeNanoseconds)/1000000000,
                "select": Double(selectingEnd.uptimeNanoseconds - selectingStart.uptimeNanoseconds)/1000000000,
                "update": Double(modifingEnd.uptimeNanoseconds - modifingStart.uptimeNanoseconds)/1000000000
            ]
        }else{ throw DateBaseErrors.connectionError }
    }
}
