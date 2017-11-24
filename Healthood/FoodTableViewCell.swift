//
//  FoodTableViewCell.swift
//  Healthood
//
//  Created by Krystian Bujak on 02/11/2017.
//  Copyright © 2017 Krystian Bujak. All rights reserved.
//

import UIKit
import FoldingCell

class FoodTableViewCell: FoldingCell {
    
    @IBOutlet var authorLabels: [UILabel]!
    @IBOutlet var titleLabels: [UILabel]!
    @IBOutlet var rateLabels: [UILabel]!
    @IBOutlet var foodImages: [UIImageView]!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var proteinLabel: UILabel!
    @IBOutlet weak var fatLabel: UILabel!
    @IBOutlet weak var carbohydratesLabel: UILabel!
    @IBOutlet weak var sugarLabel: UILabel!
    @IBOutlet weak var userProfileImage: UIImageView!
    
    var food: Food?
    var serverIP: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        foregroundView.layer.cornerRadius = 10
        foregroundView.layer.masksToBounds = true
        containerView.layer.cornerRadius = 10
        containerView.layer.masksToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func animationDuration(_ itemIndex:NSInteger, type:AnimationType)-> TimeInterval {
        
        // durations count equal it itemCount
        let durations = [0.26, 0.2, 0.2,0.2] // timing animation for each view
        return durations[itemIndex]
    }
    
    func setup(){
        if let food = self.food{
            for authorLabel in authorLabels{
                authorLabel.text = food.owner.login
            }
            for titleLabel in titleLabels{
                titleLabel.text = food.title
            }
            let avgRate = Double.average(from: food.rating)
            for rateLabel in rateLabels{
                rateLabel.text = "Ocena: \(avgRate)/5"
            }
            for foodImage in foodImages{
                if let foodImagePath = food.imagePath{
                    let imageURL = "http://" + serverIP! + foodImagePath
                    foodImage.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "placeholder.jpg"))
                }
            }
            if let profileImagePath = food.owner.profileImagePath {
                let imageURL = "http://" + serverIP! + profileImagePath
                self.userProfileImage.sd_setImage(with: URL(string: imageURL), placeholderImage: UIImage(named: "placeholder.jpg"))
            }
            self.dataLabel.text = String(describing: food.data)
            self.nameLabel.text = food.owner.name + " " + food.owner.surName
            self.caloriesLabel.text = "Kalorie: \(food.calories) kcal"
            self.proteinLabel.text = String(food.protein) + " g"
            self.carbohydratesLabel.text = String(food.carbohydrates) + " g"
            self.fatLabel.text = String(food.fat) + " g"
            self.sugarLabel.text = String(food.sugar) + " g"
        }
    }
}
