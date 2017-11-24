//
//  UIViewController.swift
//  Healthood
//
//  Created by Krystian Bujak on 10/10/2017.
//  Copyright © 2017 Krystian Bujak. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    func addTapGestureRecognizer(){
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dissmissKeyboard))
        self.view.addGestureRecognizer(tapGestureRecognizer)
    }    
    func dissmissKeyboard(){
        self.view.endEditing(true)
    }
    
    public func showWarrning(with warning: String){
        let alertController = UIAlertController(title: "Ostrzeżenie", message:
            warning, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Zamknij", style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
}
