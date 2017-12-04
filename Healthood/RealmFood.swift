//
//  RealmFood.swift
//  Healthood
//
//  Created by Krystian Bujak on 14/11/2017.
//  Copyright © 2017 Krystian Bujak. All rights reserved.
//

import Foundation
import RealmSwift

class RealmFood: Object{
    dynamic var id: String = ""
    dynamic var owner: RealmUser?
    dynamic var imagePath: String = ""
    dynamic var data: Date = Date()
    var ingridients = List<RealmIngridient>()
    dynamic var title: String = ""
    dynamic var descriptionn: String = ""
    dynamic var rating: RealmRate?
    dynamic var durationTime: Int = 0
    dynamic var calories: Int = 0
    dynamic var protein: Int = 0
    dynamic var fat: Int = 0
    dynamic var carbohydrates: Int = 0
    dynamic var sugar: Int = 0
    
    convenience init(food: Food, for user: RealmUser){
        self.init()
        self.id = food.id
        self.owner = user
        self.imagePath = (food.imagePath ?? "")!
        self.data = Date()
        var ingridients = [RealmIngridient]()
        for i in food.ingridients{
            ingridients.append(RealmIngridient(ingridient: i))
        }
        self.ingridients = List(ingridients)
        self.title = food.title
        self.descriptionn = food.description
        self.rating = RealmRate(rate: food.rating)
        self.durationTime = food.durationTime
        self.calories = food.calories
        self.protein = food.calories
        self.fat = food.fat
        self.carbohydrates = food.carbohydrates
        self.sugar = food.sugar
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
