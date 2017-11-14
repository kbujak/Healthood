//
//  RealmIngridient.swift
//  Healthood
//
//  Created by Krystian Bujak on 14/11/2017.
//  Copyright © 2017 Krystian Bujak. All rights reserved.
//

import Foundation
import RealmSwift

class RealmIngridient: Object{
    dynamic var name: String = ""
    dynamic var count: Int = 0
    dynamic var unit: String = ""
    
    convenience init(ingridient: Ingridient){
        self.init()
        self.name = ingridient.name
        self.count = ingridient.count
        self.unit = ingridient.unit
    }
}
