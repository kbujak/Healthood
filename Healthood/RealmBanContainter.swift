//
//  RealmBannContainter.swift
//  Healthood
//
//  Created by Krystian Bujak on 24/11/2017.
//  Copyright © 2017 Krystian Bujak. All rights reserved.
//

import Foundation
import RealmSwift

class RealmBanContainer: Object{
    dynamic var userId: String = ""
    dynamic var level: Int = 0
    dynamic var punishementDate: Date?
    
    convenience init(userId: String){
        self.init()
        self.userId = userId
    }
}
