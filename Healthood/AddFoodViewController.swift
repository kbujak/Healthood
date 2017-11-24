//
//  AddFoodViewController.swift
//  Healthood
//
//  Created by Krystian Bujak on 13/11/2017.
//  Copyright © 2017 Krystian Bujak. All rights reserved.
//

import UIKit

class AddFoodViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPopoverPresentationControllerDelegate {

    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var caloriesTextField: UITextField!
    @IBOutlet weak var durationTextField: UITextField!
    @IBOutlet weak var proteinTextField: UITextField!
    @IBOutlet weak var fatTextField: UITextField!
    @IBOutlet weak var carboTextField: UITextField!
    @IBOutlet weak var sugarTextField: UITextField!
    @IBOutlet weak var ingridientsTableView: UITableView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var ingridients = [Ingridient]()
    var food: Food?
    var dataBaseDelegate: DataBaseProtocol!
    lazy var postImageHelper = PostImageHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataBaseDelegate = (UIApplication.shared.delegate as! AppDelegate).dataBaseDelegate
        self.foodImageView.isUserInteractionEnabled = true
        self.foodImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(profileImgTapped)))
        self.ingridientsTableView.delegate = self
        self.ingridientsTableView.dataSource = self
    }

    @IBAction func addIngridientBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "addIngridientSegue", sender: self)
        self.ingridientsTableView.reloadData()
    }
    
    @IBAction func addFoodBtnPressed(_ sender: Any) {
        do{
            guard let image = foodImageView.image else { throw FoodListErrors.emptyImage }
            guard let name = nameTextField.text, let caloriesText = caloriesTextField.text, let durationText = durationTextField.text, let proteinText = proteinTextField.text, let fatText = fatTextField.text, let carboText = carboTextField.text, let sugarText = sugarTextField.text, let description = descriptionTextView.text else { throw FoodListErrors.unfilledFields }
            
            guard ingridients.count > 0 else { throw FoodListErrors.emptyIngridientsArray }
            
            guard let calories = Int(caloriesText), let duration = Int(durationText), let proteins = Int(proteinText), let fat = Int(fatText), let carbo = Int(carboText), let sugar = Int(sugarText) else { throw FoodListErrors.invalidType }
            
            if let db = dataBaseDelegate{
                if let user = try db.getUser(with: UserDefaults.standard.object(forKey: "logInUserId") as! String){
                    self.food = Food(owner: user, image: image, ingridients: ingridients, title: name, description: description, durationTime: duration, calories: calories, protein: proteins, fat: fat, carbohydrates: carbo, sugar: sugar)

                    if let imageName = self.postImageHelper.myImageUploadRequest(with: food!.image!, for: self.food!.id, using: db.dataBaseType, imgType: .food){
                        food?.imagePath = "/\(db.dataBaseType.rawValue)/\(ImageType.food.rawValue)/\(imageName)"
                        try db.addFood(with: food!)
                    }
                }
            }
            performSegue(withIdentifier: "correctAddFoodSegue", sender: self)
        }catch let error as Error{
            
        }
    }
    
    @IBAction func unwindToAddFoodViewController(for segue: UIStoryboardSegue){
        if segue.identifier == "correctAddIngridientSegue"{
            if let addIngridientVC = segue.source as? AddIngridientViewController{
                if let ingridient = addIngridientVC.ingridient{
                    self.ingridients.append(ingridient)
                    self.ingridientsTableView.reloadData()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ingridients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingridientItemId", for: indexPath) as! IngridientTableViewCell
        let ingridient = ingridients[indexPath.row]
        cell.nameLabel.text = ingridient.name
        cell.countLabel.text = String(ingridient.count)
        cell.unitLabel.text = ingridient.unit
        return cell
    }
}

extension AddFoodViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    @objc fileprivate func profileImgTapped(){
        let allertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        allertController.addAction(UIAlertAction(title: "Take photo", style: .default){
            actionAllert in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .camera
                imagePicker.allowsEditing = true
                self.present(imagePicker, animated: true, completion: nil)
            }
        })
        allertController.addAction(UIAlertAction(title: "Choose photo", style: .default){
            actionAllert in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .photoLibrary
                imagePicker.allowsEditing = true
                self.present(imagePicker, animated: true, completion: nil)
            }
        })
        
        allertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(allertController, animated: true, completion: nil)
    }
    
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        foodImageView.contentMode = .scaleAspectFill
        foodImageView.clipsToBounds = true
        foodImageView.image = image
        dismiss(animated:true, completion: nil)
    }
}
