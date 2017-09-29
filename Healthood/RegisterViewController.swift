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
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmationTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createDatePicker()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createDatePicker(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(testDateTextField))
        toolbar.setItems([doneButton], animated: false)
        dateTextField.inputAccessoryView = toolbar
        
        
        datePicker.datePickerMode = .date
        dateTextField.inputView = datePicker
    }
    
    func testDateTextField(){
        dateTextField.text = "\(datePicker.date)"
        self.view.endEditing(true)
    }
}
