//
//  RegisterHelper.swift
//  Healthood
//
//  Created by Krystian Bujak on 09/10/2017.
//  Copyright © 2017 Krystian Bujak. All rights reserved.
//

import Foundation

struct RegisterHelper{
    static func checkName(for name: String?) -> String?{
        guard let name = name else { return nil }
        return !name.isEmpty ? name.capitalized : nil
    }
    
    static func checkSurname(for surname: String?) -> String?{
        guard let surname = surname else { return nil }
        return !surname.isEmpty ? surname.capitalized : nil
    }
    
    static func checkLogin(for login: String?) -> String?{
        guard let login = login else { return nil }
        return !login.isEmpty ? login : nil
    }
    
    static func checkPassw(_ passw: String?, with passw2: String?) -> String?{
        guard let passw = passw, let passw2 = passw2 else { return nil }
        guard passw == passw2 else { return nil }
        guard passw.characters.count >= 8 else { return nil }
        return passw
    }
    
    static func checkEmail(for email: String?) -> String?{
        guard let email = email else { return nil }
        let pat = "\\s*[\\w\\d.%_+-]+@[\\w\\d]+\\.\\w{2,}"
        let regex = try! NSRegularExpression(pattern: pat, options: [])
        let numberOfMatches = regex.numberOfMatches(in: email, options: [], range: NSRange(location: 0, length: email.characters.count))
        return numberOfMatches > 0 ? email : nil        
    }
}
