//
//  RegisterViewController.swift
//  Healthood
//
//  Created by Krystian Bujak on 29/09/2017.
//  Copyright © 2017 Krystian Bujak. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwTextField: UITextField!
    @IBOutlet weak var retPasswTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    var dataBase: DataBaseProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addTapGestureRecognizer()
        self.dataBase = (UIApplication.shared.delegate as! AppDelegate).dataBaseDelegate
    }

    @IBAction func registerUser(_ sender: Any) {
        do{
            guard let name = RegisterHelper.checkName(for: nameTextField.text) else { throw RegisterErrors.nameError }
            guard let surname = RegisterHelper.checkSurname(for: surnameTextField.text) else { throw RegisterErrors.surnameError }
            guard let login = RegisterHelper.checkLogin(for: loginTextField.text) else { throw RegisterErrors.loginError }
            guard let passw = RegisterHelper.checkPassw(passwTextField.text, with: retPasswTextField.text) else { throw RegisterErrors.passwordError }
            guard let email = RegisterHelper.checkEmail(for: emailTextField.text) else { throw RegisterErrors.emailError }
            guard let db = self.dataBase else { throw DateBaseErrors.connectionError }
            let user = User(name: name, surName: surname, login: login, email: email, password: passw)
            try db.registerUser(with: user)
            UserDefaults.standard.set(user.id, forKey: "userId")
            UserDefaults.standard.synchronize()
            performSegue(withIdentifier: "registerSegue", sender: self)
        }catch let registerError as RegisterErrors {
            errorLabel.isHidden = false
            errorLabel.text = registerError.rawValue
        }catch let dbError as DateBaseErrors{
            errorLabel.isHidden = false
            errorLabel.text = dbError.rawValue
        }catch is Error{
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
