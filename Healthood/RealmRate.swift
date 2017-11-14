//
//  RealmRate.swift
//  Healthood
//
//  Created by Krystian Bujak on 14/11/2017.
//  Copyright © 2017 Krystian Bujak. All rights reserved.
//

import Foundation
import RealmSwift

class RealmRate: Object{
    dynamic var sum: Int = 0
    dynamic var count: Int = 0
    
    convenience init(rates: [Int]){
        self.init()
        for rate in rates{
            self.sum += rate
        }
        self.count = rates.count
    }
}
