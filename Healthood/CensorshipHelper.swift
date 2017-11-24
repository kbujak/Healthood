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
    
    private func loadVulgarisms(){
        let file = "wulgaryzmy.txt" //this is the file. we will write to and read from it
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first{
            let fileURL = dir.appendingPathComponent(file)
            
            if let text = try? String(contentsOf: fileURL, encoding: .utf8){
                self.vulgarisms = text.split(separator: ",").map{
                    return String($0)
                }
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
    
    init(){
        loadVulgarisms()
        setupNSRegularExpresions()
    }
    
    public func containsVulgarism(in text: String) -> Bool{
        for regex in self.vulgarismRegex!{
            let results = regex.matches(in: text, options: [], range: NSRange(location: 0, length: text.count))
            
            if results.count > 0{
                return true
            }
        }
        return false
    }
}

//let censor = Censor()
//
//let text = "ajksdhasas asdkjaskd asdasdas aasdakurwasdasd"

//print(censor.containsVulgarism(in: text))
let start = DispatchTime.now()
for i in 1...1000000000{
    
}
let end = DispatchTime.now()

print(Double(end.uptimeNanoseconds - start.uptimeNanoseconds) / 1000000000.0)
//let regex = try? NSRegularExpression(pattern: "\\w*dup\\w+", options: .caseInsensitive)
//let text = "stara Twoja sdsDuP"
//if let reg = regex{
//    let results = reg.matches(in: text, options: [], range: NSRange(location: 0, length: text.count))
//    print(results.count)
//    let t = results.map {
//        String(text[Range($0.range, in: text)!])
//    }
//
//    print(t.first!)
//}

