//
//  RegisterHelper.swift
//  Healthood
//
//  Created by Krystian Bujak on 09/10/2017.
//  Copyright © 2017 Krystian Bujak. All rights reserved.
//

import Foundation

struct RegisterHelper{
    static let censorship = CensorshipHelper()
    
    static func checkName(for name: String?) throws -> String{
        guard let name = name, !name.isEmpty else { throw RegisterErrors.nameError }
        guard censorship.isAllowedWord(name) else { throw RegisterErrors.vulgarismError}
        return name
    }
    
    static func checkSurname(for surname: String?) throws -> String{
        guard let surname = surname, !surname.isEmpty else { throw RegisterErrors.surnameError }
        guard censorship.isAllowedWord(surname) else { throw RegisterErrors.vulgarismError}
        return surname
    }
    
    static func checkLogin(for login: String?) throws -> String{
        guard let login = login, !login.isEmpty else { throw RegisterErrors.loginError }
        guard censorship.isAllowedWord(login) else { throw RegisterErrors.vulgarismError}
        return login
    }
    
    static func checkPassw(_ passw: String?, with passw2: String?) throws -> String{
        guard let passw = passw, let passw2 = passw2, passw == passw2, passw.characters.count >= 8 else { throw RegisterErrors.passwordError }
        return passw
    }
    
    static func checkEmail(for email: String?) throws -> String{
        guard let email = email, (try! NSRegularExpression(pattern: "\\s*[\\w\\d.%_+-]+@[\\w\\d]+\\.\\w{2,}", options: [])).numberOfMatches(in: email, options: [], range: NSRange(location: 0, length: email.characters.count)) > 0 else { throw RegisterErrors.emailError }
        guard censorship.isAllowedWord(email) else { throw RegisterErrors.vulgarismError}
        return email
    }
}
