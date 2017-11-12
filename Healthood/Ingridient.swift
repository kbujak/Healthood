//
//  Ingridient.swift
//  Healthood
//
//  Created by Krystian Bujak on 14/11/2017.
//  Copyright © 2017 Krystian Bujak. All rights reserved.
//

import Foundation

class Ingridient{
    var name: String
    var count: Int
    var unit: String
    
    init(name: String, count: Int, unit: String){
        self.name = name
        self.count = count
        self.unit = unit
    }
}
