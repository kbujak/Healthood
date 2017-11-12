//
//  Double.swift
//  Healthood
//
//  Created by Krystian Bujak on 14/11/2017.
//  Copyright © 2017 Krystian Bujak. All rights reserved.
//

import Foundation

extension Double{
    static func average(from array: [Int]) -> Double{
        var avg = 0
        for t in array{
            avg += t
        }
        return Double(avg)/Double(array.count)
    }
}
