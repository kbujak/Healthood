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
}
