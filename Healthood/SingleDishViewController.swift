//
//  SingleDishViewController.swift
//  Healthood
//
//  Created by Krystian Bujak on 07/11/2017.
//  Copyright © 2017 Krystian Bujak. All rights reserved.
//

import UIKit

class SingleDishViewController: UIViewController {
    
    @IBOutlet weak var ingridientListHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ingridientListHeight.constant = 30
    }

}
