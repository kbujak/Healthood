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
    var id: UUID
    var owner: User
    var image: UIImage
    var data: Date
    var ingridients: [Ingridient]
    var title: String
    var description: String
    var rating: [Int]
    var durationTime: Int
    var calories: Int
    var protein: Int
    var fat: Int
    var carbohydrates: Int
    var sugar: Int
    
    init(owner: User, image: UIImage, ingridients: [Ingridient], title: String, description: String, durationTime: Int, calories: Int, protein: Int, fat: Int, carbohydrates: Int, sugar: Int){
        self.id = UUID.init()
        self.owner = owner
        self.image = image
        self.data = Date()
        self.ingridients = ingridients
        self.title = title
        self.description = description
        self.rating = [0]
        self.durationTime = durationTime
        self.calories = calories
        self.protein = protein
        self.fat = fat
        self.carbohydrates = carbohydrates
        self.sugar = sugar
    }
    
    init(){
        self.id = UUID.init()
        self.owner = User()
        self.image = #imageLiteral(resourceName: "LoginBackground2")
        self.data = Date()
        self.ingridients = []
        self.title = "Bułka z syznka i pomidorem"
        self.description = "Pokrók bułkę, pokrój pomidora, nałóż szynke na bułkę, nałóż pomidora"
        self.rating = [4]
        self.durationTime = 10
        self.calories = 100
        self.protein = 32
        self.fat = 50
        self.carbohydrates = 60
        self.sugar = 7
    }
}
