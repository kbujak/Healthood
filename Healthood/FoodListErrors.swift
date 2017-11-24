//
//  FoodListErrors.swift
//  Healthood
//
//  Created by Krystian Bujak on 13/11/2017.
//  Copyright © 2017 Krystian Bujak. All rights reserved.
//

import Foundation

enum FoodListErrors: String, Error{
    case unfilledFields = "You have unfilled fields"
    case invalidType = "You used improper type"
    case emptyImage = "You must add image"
    case emptyIngridientsArray = "You must add ingridients"
    case vulgarismError = "Chciałeś dodać tekst z wulgaryzmem. Dostajesz ostrzezenie!"
    case bannedUser = "Masz tymczasowego bana, musisz poczekac"
    case invalidCredentials = "Złe dane"
}
