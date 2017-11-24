//
//  ViewController.swift
//  Healthood
//
//  Created by Krystian Bujak on 25/09/2017.
//  Copyright © 2017 Krystian Bujak. All rights reserved.
//

import UIKit
import RealmSwift

class LoginViewController: UIViewController {

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    var dataBaseDelegate: DataBaseProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addTapGestureRecognizer()
        self.dataBaseDelegate = (UIApplication.shared.delegate as! AppDelegate).dataBaseDelegate
    }
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        do{
            guard let login = loginTextField.text else { return }
            guard let password = passwordTextField.text else { return }
            guard let db = dataBaseDelegate else { return }
            guard let user = try db.loginUser(with: login, and: password) else { return }

            UserDefaults.standard.set(user.id, forKey: "logInUserId")
            UserDefaults.standard.synchronize()
            performSegue(withIdentifier: "loginSegue", sender: self)
        }catch let dbError as DateBaseErrors{

        }catch is Error{

        }
    }
    
    @IBAction func unwindToLoginVC(segue:UIStoryboardSegue) { }
}

