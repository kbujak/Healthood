//
//  SQliteFoodTable.swift
//  Healthood
//
//  Created by Krystian Bujak on 09/12/2017.
//  Copyright © 2017 Krystian Bujak. All rights reserved.
//

import Foundation
import SQLite

class SQliteFoodTable{
    let foods = Table("foods")
    let id = Expression<String>("id")
    let id_user = Expression<String>("id_user")
    let imagepath = Expression<String>("imagepath")
    let date = Expression<Date>("date")
    let title = Expression<String>("title")
    let description = Expression<String>("description")
    let id_rate = Expression<Int>("id_rate")
    let duration_time = Expression<Int>("duration_time")
    let calories = Expression<Int>("calories")
    let protein = Expression<Int>("protein")
    let fat = Expression<Int>("fat")
    let carbohydrates = Expression<Int>("carbohydrates")
    let sugar = Expression<Int>("sugar")
}
