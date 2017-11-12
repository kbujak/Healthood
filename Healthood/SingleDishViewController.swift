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
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var autorLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var proteinLabel: UILabel!
    @IBOutlet weak var fatLabel: UILabel!
    @IBOutlet weak var carbohydratesLabel: UILabel!
    @IBOutlet weak var sugarLabel: UILabel!
    @IBOutlet weak var ingridientsTextView: UITextView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var authorImageView: UIImageView!
    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var rateImageView: UIImageView!
    
    var food: Food?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ingridientListHeight.constant = 30
        setup()
    }

    private func setup(){
        if let food = food{
            titleLabel.text = food.title
            autorLabel.text = food.owner.name + " " + food.owner.surName
            durationLabel.text = "Czas: \(food.durationTime) min."
            let avgRate = Double.average(from: food.rating)
            rateLabel.text = "Ocena: \(avgRate)/5"
            caloriesLabel.text = "Kalorie: \(food.calories) kcal"
            proteinLabel.text = "\(food.protein) g"
            fatLabel.text = "\(food.fat) g"
            carbohydratesLabel.text = "\(food.carbohydrates) g"
            sugarLabel.text = "\(food.sugar) g"
            var ingridientText = ""
            for ingridient in food.ingridients{
                ingridientText = ingridientText + "\(ingridient.name)\t\(ingridient.count)\t\(ingridient.unit)\n"
            }
            ingridientListHeight.constant = CGFloat(food.ingridients.count * 20) + 20.0
            ingridientsTextView.text = ingridientText
            descriptionTextView.text = food.description
            authorImageView.image = food.owner.profileImage
            foodImageView.image = food.image
        }
    }
}
