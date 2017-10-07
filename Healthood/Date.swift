//
//  Date.swift
//  Healthood
//
//  Created by Krystian Bujak on 07/10/2017.
//  Copyright © 2017 Krystian Bujak. All rights reserved.
//

import Foundation

extension Date{
    init (from dateInString: String){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        self = dateFormatter.date(from: dateInString)!
    }
}
