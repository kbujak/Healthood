//
//  ProfileViewController.swift
//  Healthood
//
//  Created by Krystian Bujak on 02/11/2017.
//  Copyright © 2017 Krystian Bujak. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    var dataBaseDelegate: RealmController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
        self.dataBaseDelegate = (UIApplication.shared.delegate as! AppDelegate).dataBaseDelegate
        
        if let logInUserId = UserDefaults.standard.object(forKey: "logInUserId") as? String{
            if let logInUser = try? dataBaseDelegate!.getUser(with: logInUserId){
                if let logInUser = logInUser{
                    loginLabel.text = logInUser.login
                    nameLabel.text = "\(logInUser.name) \(logInUser.surName)"
                    emailLabel.text = logInUser.email
                }
            }
        }
    }
    
    @IBAction func logoutBtnPressed(_ sender: Any) {
        UserDefaults.standard.set(nil, forKey: "logInUserId")
        UserDefaults.standard.synchronize()
        performSegue(withIdentifier: "logoutSegue", sender: self)
    }
    
    private func viewSetup(){
        profileImageView.layer.borderWidth = 2
        profileImageView.layer.masksToBounds = false
        profileImageView.layer.borderColor = UIColor.white.cgColor
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2
        profileImageView.clipsToBounds = true
    }
}
