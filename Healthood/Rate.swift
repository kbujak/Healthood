//
//  Rate.swift
//  Healthood
//
//  Created by Krystian Bujak on 04/12/2017.
//  Copyright © 2017 Krystian Bujak. All rights reserved.
//

import Foundation

class Rate{
    var sum: Int = 0
    var count: Int = 0
    
    init(sum: Int, count: Int){
        self.sum = sum
        self.count = count
    }
    
    init(realmRate: RealmRate){
        self.sum = realmRate.sum
        self.count = realmRate.count
    }
}
