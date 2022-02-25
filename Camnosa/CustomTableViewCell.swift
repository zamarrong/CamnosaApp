//
//  CustomTableViewCell.swift
//  Camnosa
//
//  Created by Jorge Zamarrón on 20/10/16.
//  Copyright © 2016 Sifen. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var CurrencyNameLabel: UILabel!
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var BuyLabel: UILabel!
    @IBOutlet weak var SellLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
