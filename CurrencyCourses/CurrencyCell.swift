//
//  CurrencyCell.swift
//  CurrencyCourses
//
//  Created by Aleksey Lavrukhin on 29.06.2020.
//  Copyright © 2020 Aleksey Lavrukhin. All rights reserved.
//

import UIKit

class CurrencyCell: UITableViewCell {

    @IBOutlet weak var imageFlag: UIImageView!
    @IBOutlet weak var labelCurrencyName: UILabel!
    @IBOutlet weak var labelCurrencyCode: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initCell(currency: Currency){
        imageFlag.image = currency.imageFlag
        labelCurrencyName.text = currency.txtName
        labelCurrencyCode.text = currency.charCode
    }

}
