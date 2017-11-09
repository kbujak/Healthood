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
    var delegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addTapGestureRecognizer()
    }
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        do{
            guard let email = loginTextField.text else { return }
            guard let password = loginTextField.text else { return }
            guard let db = delegate.dataBaseDelegate else { return }
            let user = try db.loginUser(with: email, and: password)
            UserDefaults.standard.set(user.id, forKey: "userId")
            UserDefaults.standard.synchronize()
            performSegue(withIdentifier: "loginSegue", sender: self)
        }catch let dbError as DateBaseErrors{
            
        }catch is Error{
            
        }
    }
    
    @IBAction func unwindToLoginVC(segue:UIStoryboardSegue) { }
}

