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
    
    var dataBaseDelegate: DataBaseProtocol?
    lazy var censorshipHelper = CensorshipHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addTapGestureRecognizer()
        self.dataBaseDelegate = (UIApplication.shared.delegate as! AppDelegate).dataBaseDelegate
    }

    @IBAction func registerUser(_ sender: Any) {
        do{
            let name = try RegisterHelper.checkName(for: nameTextField.text)
            let surname = try RegisterHelper.checkSurname(for: surnameTextField.text)
            let login = try RegisterHelper.checkLogin(for: loginTextField.text)
            let passw = try RegisterHelper.checkPassw(passwTextField.text, with: retPasswTextField.text)
            let email = try RegisterHelper.checkEmail(for: emailTextField.text)
            guard let db = self.dataBaseDelegate else { throw DateBaseErrors.connectionError }
            
            let user = User(name: name, surName: surname, login: login, email: email, password: passw)
            try db.registerUser(with: user)
            UserDefaults.standard.set(user.id, forKey: "logInUserId")
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
