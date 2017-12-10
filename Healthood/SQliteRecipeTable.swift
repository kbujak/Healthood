//
//  SQliteRecipeTable.swift
//  Healthood
//
//  Created by Krystian Bujak on 09/12/2017.
//  Copyright © 2017 Krystian Bujak. All rights reserved.
//

import Foundation
import SQLite

class SQliteRecipeTable{
    let recipes = Table("recipe")
    let id = Expression<Int>("id")
    let food_id = Expression<String>("food_id")
    let id_ingridient = Expression<Int>("id_ingridient")
}
