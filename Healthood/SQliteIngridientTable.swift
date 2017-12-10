//
//  SQliteIngridient.swift
//  Healthood
//
//  Created by Krystian Bujak on 09/12/2017.
//  Copyright © 2017 Krystian Bujak. All rights reserved.
//

import Foundation
import SQLite

class SQliteIngridientTable{
    let ingridients = Table("ingridients")
    let id = Expression<Int>("id")
    let name = Expression<String>("name")
    let count = Expression<Int>("count")
    let unit = Expression<String>("unit")
}
