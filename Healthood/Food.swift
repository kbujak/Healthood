//
//  Food.swift
//  Healthood
//
//  Created by Krystian Bujak on 13/11/2017.
//  Copyright © 2017 Krystian Bujak. All rights reserved.
//

import Foundation
import UIKit

class Food{
    var id: String
    var owner: User
    var image: UIImage?
    var imagePath: String?
    var data: Date
    var ingridients: [Ingridient]
    var title: String
    var description: String
    var rating: Rate
    var durationTime: Int
    var calories: Int
    var protein: Int
    var fat: Int
    var carbohydrates: Int
    var sugar: Int
    
    init(owner: User, ingridients: [Ingridient], title: String, description: String, durationTime: Int, calories: Int, protein: Int, fat: Int, carbohydrates: Int, sugar: Int, image: UIImage? = nil, imagePath: String? = nil){
        self.id = UUID.init().uuidString
        self.owner = owner
        self.image = image
        self.imagePath = imagePath
        self.data = Date()
        self.ingridients = ingridients
        self.title = title
        self.description = description
        self.rating = Rate(sum: 0, count: 0)
        self.durationTime = durationTime
        self.calories = calories
        self.protein = protein
        self.fat = fat
        self.carbohydrates = carbohydrates
        self.sugar = sugar
    }
    
    init(realmFood: RealmFood){
        self.id = realmFood.id
        self.owner = User(realmUser: realmFood.owner!)
        self.data = realmFood.data
        self.title = realmFood.title
        self.description = realmFood.descriptionn
        self.durationTime = realmFood.durationTime
        self.calories = realmFood.calories
        self.protein = realmFood.protein
        self.fat = realmFood.fat
        self.carbohydrates = realmFood.carbohydrates
        self.sugar = realmFood.sugar
        self.rating = Rate(realmRate: realmFood.rating!)
        self.ingridients = [Ingridient]()
        self.imagePath = realmFood.imagePath
        for realmIngridient in realmFood.ingridients{
            self.ingridients.append(Ingridient(realmIngridient: realmIngridient))
        }
    }
    
    init(){
        self.id = UUID.init().uuidString
        self.owner = User()
        self.image = #imageLiteral(resourceName: "LoginBackground2")
        self.data = Date()
        self.ingridients = []
        self.title = String.randomString(length: 5)
        self.description = String.randomString(length: 7)
        self.rating = Rate(sum: 0, count: 0)
        self.durationTime = 10
        self.calories = 100
        self.protein = 32
        self.fat = 50
        self.carbohydrates = 60
        self.sugar = 7
    }
}
