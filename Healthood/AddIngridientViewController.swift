//
//  AddIngridientViewController.swift
//  Healthood
//
//  Created by Krystian Bujak on 13/11/2017.
//  Copyright © 2017 Krystian Bujak. All rights reserved.
//

import UIKit

class AddIngridientViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var countTextField: UITextField!
    @IBOutlet weak var unitTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    var ingridient: Ingridient?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func addBtnPressed(_ sender: Any) {
        do{
            guard let name = String.isEmptyOrNil(with: nameTextField.text) else { throw FoodListErrors.unfilledFields }
            guard let countText = String.isEmptyOrNil(with: countTextField.text) else { throw FoodListErrors.unfilledFields }
            guard let unit = String.isEmptyOrNil(with: unitTextField.text) else { throw FoodListErrors.unfilledFields }
            guard let count = Int(countText) else { throw FoodListErrors.invalidType }
            self.ingridient = Ingridient(name: name, count: count, unit: unit)
            performSegue(withIdentifier: "correctAddIngridientSegue", sender: self)
        }catch let error as Error{
            errorLabel.isHidden = false
            errorLabel.text = (error as! FoodListErrors).rawValue
        }
    }
}
