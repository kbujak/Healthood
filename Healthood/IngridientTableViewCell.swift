//
//  IngridientTableViewCell.swift
//  Healthood
//
//  Created by Krystian Bujak on 13/11/2017.
//  Copyright © 2017 Krystian Bujak. All rights reserved.
//

import UIKit

class IngridientTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
