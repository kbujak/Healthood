//
//  ProfileViewController.swift
//  Healthood
//
//  Created by Krystian Bujak on 02/11/2017.
//  Copyright © 2017 Krystian Bujak. All rights reserved.
//

import UIKit
import SDWebImage

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    var dataBaseDelegate: DataBaseProtocol?
    lazy var postImageHelper = PostImageHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataBaseDelegate = (UIApplication.shared.delegate as! AppDelegate).dataBaseDelegate
        viewSetup()
        setupUserData()
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
        profileImageView.isUserInteractionEnabled = true
        profileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(profileImgTapped)))
    }
    
    private func setupUserData(){
        if let logInUserId = UserDefaults.standard.object(forKey: "logInUserId") as? String{
            if let logInUser = try? dataBaseDelegate!.getUser(with: logInUserId){
                if let logInUser = logInUser{
                    if logInUser.profileImagePath != nil{
                        profileImageView.image = UIImage(contentsOfFile: logInUser.profileImagePath!)
                    }
                    loginLabel.text = logInUser.login
                    nameLabel.text = "\(logInUser.name) \(logInUser.surName)"
                    emailLabel.text = logInUser.email
                }
            }
        }
    }
    
    @objc private func profileImgTapped(){
        let allertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        allertController.addAction(UIAlertAction(title: "Take photo", style: .default){
            actionAllert in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                DispatchQueue.main.async {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .camera
                imagePicker.allowsEditing = true
                self.present(imagePicker, animated: true, completion: nil)
                }
            }
        })
        allertController.addAction(UIAlertAction(title: "Choose photo", style: .default){
            actionAllert in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                DispatchQueue.main.async {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .photoLibrary
                imagePicker.allowsEditing = true
                self.present(imagePicker, animated: true, completion: nil)
                }
            }
        })
        allertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(allertController, animated: true, completion: nil)
    }
    
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        profileImageView.image = image
            if let db = self.dataBaseDelegate{
                let imagePath = "/Users/Booyac/Documents/Pictures/" + db.dataBaseType.rawValue + "/profile/" + String.SHA256(self.nameLabel.text! + String.randomString(length: 15))! + ".jpg"
                try? db.changeUserProfileImage(with: imagePath, for: UserDefaults.standard.object(forKey: "logInUserId") as! String)
                if let imageData = UIImageJPEGRepresentation(image, 0.5){
                    FileManager.default.createFile(atPath: imagePath, contents: imageData)
                }
            }
            self.dismiss(animated:true, completion: nil)
    }
}
