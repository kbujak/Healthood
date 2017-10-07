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
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmationTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    var dataBaseController: DataBaseProtocol!
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createDatePicker()
        self.dataBaseController = RealmController()
    }

    @IBAction func registerUser(_ sender: Any) {
        guard let name = self.nameTextField.text else { return }
        guard let surname = self.surnameTextField.text else { return }
        guard let login = self.loginTextField.text else { return }
        guard let password = self.passwordTextField.text else { return }
        guard let passwordConfirmation = self.passwordConfirmationTextField.text else { return }
        guard password == passwordConfirmation else { return }
        guard let email = self.emailTextField.text else { return }
        guard let date = self.dateTextField.text else { return }
        
        let user = User(name: name, surName: surname, login: login, email: email, password: password, birthday: Date(from: date))
        self.dataBaseController.registerUser(with: user)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createDatePicker(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(writeDateOnTextField))
        toolbar.setItems([doneButton], animated: false)
        dateTextField.inputAccessoryView = toolbar
        
        
        datePicker.datePickerMode = .date
        dateTextField.inputView = datePicker
    }
    
    func writeDateOnTextField(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateTextField.text = String(describing: dateFormatter.string(from: datePicker.date))
        self.view.endEditing(true)
    }
}
