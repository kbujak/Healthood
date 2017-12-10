//
//  SQliteRate.swift
//  Healthood
//
//  Created by Krystian Bujak on 09/12/2017.
//  Copyright © 2017 Krystian Bujak. All rights reserved.
//

import Foundation
import SQLite

class SQliteRateTable{
    let rates = Table("rates")
    let id = Expression<Int>("id")
    let sum = Expression<Int>("sum")
    let count = Expression<Int>("count")
}
