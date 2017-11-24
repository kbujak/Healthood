//
//  main.swift
//  Censor
//
//  Created by Krystian Bujak on 21/11/2017.
//  Copyright © 2017 Krystian Bujak. All rights reserved.
//

import Foundation

class CensorshipHelper{
    var vulgarisms: [String]?
    var vulgarismRegex: [NSRegularExpression]?
    
    init(){
        loadVulgarisms()
        setupNSRegularExpresions()
    }
    
    private func loadVulgarisms(){
        let fileURL = URL(fileURLWithPath: "/Users/Booyac/Documents/wulgaryzmy.txt")
        
        if let text = try? String(contentsOf: fileURL, encoding: .utf8){
            self.vulgarisms = text.split(separator: ",").map{
                return String($0)
            }
        }
    }
    
    private func setupNSRegularExpresions(){
        if let vulgarisms = self.vulgarisms{
            self.vulgarismRegex = vulgarisms.map{
                try! NSRegularExpression(pattern: "\\w*\($0)\\w*\\b", options: .caseInsensitive) // "\\w*\($0)\\w*"
            }
        }
    }
    

    
    public func isAllowedWord(_ text: String) -> Bool{
        for regex in self.vulgarismRegex!{
            let results = regex.matches(in: text, options: [], range: NSRange(location: 0, length: text.count))
            
            if results.count > 0{
                return false
            }
        }
        return true
    }
}
